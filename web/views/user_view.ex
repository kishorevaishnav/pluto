defmodule Pluto.UserView do
  use Pluto.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Pluto.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Pluto.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      email: user.email,
      password_digest: user.password_digest,
      status: user.status,
      reference_id: user.reference_id,
      role: user.role,
      sessionid: user.sessionid}
  end
end
