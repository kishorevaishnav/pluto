defmodule Pluto.CommentController do
  use Pluto.Web, :controller
  require Logger

  alias Pluto.Comment

  def index(conn, %{"ticket_id" => tid}) do
    IO.inspect "-----------------"
    IO.inspect tid
    IO.inspect "-----------------"
    comments = Repo.all(from c in Comment,
                        where: c.ticket_id == ^tid)
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"ticket_id" => ticket_id, "comment" => comment_params} ) do
    Logger.debug "INSPECT ticket_id ===== #{inspect(ticket_id)}"
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

  def show(conn, %{"ticket_id" => ticket_id, "id" => id}) do
    # TODO: Need to handle if it doesn't have any records to display or more
    # than one record to display. This works only if there are only one record.
    comment = Repo.get_by!(Comment, ticket_id: ticket_id, id: id)
    Logger.debug "INSPECT comment ===== #{inspect(comment)}"
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"ticket_id" => ticket_id, "id" => id, "comment" => comment_params}) do
    comment = Repo.get_by!(Comment, ticket_id: ticket_id, id: id)
    changeset = Comment.changeset(comment, Map.put(comment_params, "ticket_id", ticket_id))

    case Repo.update(changeset) do
      {:ok, comment} ->
        render(conn, "show.json", comment: comment)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"ticket_id" => ticket_id, "id" => id}) do
    comment = Repo.get_by!(Comment, ticket_id: ticket_id, id: id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    send_resp(conn, :no_content, "")
  end
end
