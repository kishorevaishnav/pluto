defmodule Pluto.CommentView do
  use Pluto.Web, :view

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, Pluto.CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, Pluto.CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      value: comment.value,
      ticket_id: comment.ticket_id}
  end
end
