defmodule Pluto.TicketTest do
  use Pluto.ModelCase

  alias Pluto.Ticket

  @valid_attrs %{description: "some content", subject: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ticket.changeset(%Ticket{}, @invalid_attrs)
    refute changeset.valid?
  end
end
