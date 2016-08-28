defmodule Pluto.TicketController do
  use Pluto.Web, :controller
  require Logger

  alias Pluto.Ticket

  def index(conn, _params) do
    tickets = Repo.all(Ticket)
    render(conn, "index.json", tickets: tickets)
  end

  def create(conn, %{"ticket" => ticket_params}) do
    # Logger.debug "Logging this text!"
    changeset = Ticket.changeset(%Ticket{}, ticket_params)

    case Repo.insert(changeset) do
      {:ok, ticket} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", ticket_path(conn, :show, ticket))
        |> render("show.json", ticket: ticket)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)
    render(conn, "show.json", ticket: ticket)
  end

  def update(conn, %{"id" => id, "ticket" => ticket_params}) do
    ticket = Repo.get!(Ticket, id)
    changeset = Ticket.changeset(ticket, ticket_params)

    case Repo.update(changeset) do
      {:ok, ticket} ->
        render(conn, "show.json", ticket: ticket)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Pluto.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(ticket)

    send_resp(conn, :no_content, "")
  end
end
