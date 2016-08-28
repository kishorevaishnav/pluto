defmodule Pluto.CommentController do
  use Pluto.Web, :controller
  require Logger

  alias Pluto.Comment

  def index(conn, _params) do
    comments = Repo.all(Comment)
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"ticket_id" => ticket_id, "comment" => comment_params} ) do
    Logger.debug "--> Ticket ID : #{ticket_id}"
    Logger.debug "---------------------------------------------"
    changeset = Comment.changeset(%Comment{}, Map.put(comment_params, "ticket_id", ticket_id))

    case Repo.insert(changeset) do
      {:ok, comment} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ticket_comment_path(conn, :show, ticket_id, comment))
        |> render("show.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Repo.get!(Comment, id)
    changeset = Comment.changeset(comment, comment_params)

    case Repo.update(changeset) do
      {:ok, comment} ->
        render(conn, "show.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Repo.get!(Comment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    send_resp(conn, :no_content, "")
  end
end
