defmodule Pluto.UserController do
  use Pluto.Web, :controller

  alias Pluto.User

  def authenticate(conn, %{"user" => user_params}) do
    query = (from user in User,
            where: user.username == ^user_params["username"],
            where: user.password_digest == ^user_params["password_digest"],
            select: user)
    user = Repo.one(query)
    user = if :nil != user and :nil == user.sessionid do
      User.changeset(user, %{"sessionid" => random_string(64)})
      |> Repo.update
      Repo.one(query)
    else
      user
    end
    render(conn, "show.json", user: user)
  end

  def index(conn, %{"sessionid" => sessionid}) do
    query = (from user in User,
            where: user.sessionid == ^sessionid,
            select: user)
    user = Repo.one(query)
    if :nil == user do
      conn
      |> put_status(404)
      |> render(Pluto.UserView, "error.json", %{
        error: "resource not found",
        error_code: 404
      })
    else
      users = Repo.all(User)
      render(conn, "index.json", users: users)
    end
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "sessionid" => sessionid}) do
    query = (from user in User,
            where: user.sessionid == ^sessionid,
            select: user)
    user = Repo.one(query)
    if :nil == user do
      conn
      |> put_status(404)
      |> render(Pluto.UserView, "error.json", %{
        error: "resource not found",
        error_code: 404
      })
    else
      user = Repo.get!(User, id)
      render(conn, "show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get!(User, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user)

    send_resp(conn, :no_content, "")
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64
    |> binary_part(0, length)
  end

end
