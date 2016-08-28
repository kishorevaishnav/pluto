defmodule Pluto.TicketControllerTest do
  use Pluto.ConnCase

  alias Pluto.Ticket
  @valid_attrs %{description: "some content", subject: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, ticket_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = get conn, ticket_path(conn, :show, ticket)
    assert json_response(conn, 200)["data"] == %{"id" => ticket.id,
      "subject" => ticket.subject,
      "description" => ticket.description}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, ticket_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, ticket_path(conn, :create), ticket: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Ticket, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, ticket_path(conn, :create), ticket: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = put conn, ticket_path(conn, :update, ticket), ticket: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Ticket, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = put conn, ticket_path(conn, :update, ticket), ticket: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    ticket = Repo.insert! %Ticket{}
    conn = delete conn, ticket_path(conn, :delete, ticket)
    assert response(conn, 204)
    refute Repo.get(Ticket, ticket.id)
  end
end
