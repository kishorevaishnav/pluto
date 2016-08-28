defmodule Pluto.TicketView do
  use Pluto.Web, :view

  def render("index.json", %{tickets: tickets}) do
    %{data: render_many(tickets, Pluto.TicketView, "ticket.json")}
  end

  def render("show.json", %{ticket: ticket}) do
    %{data: render_one(ticket, Pluto.TicketView, "ticket.json")}
  end

  def render("ticket.json", %{ticket: ticket}) do
    %{id: ticket.id,
      subject: ticket.subject,
      description: ticket.description}
  end
end
