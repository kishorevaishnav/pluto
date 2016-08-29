defmodule Pluto.UserTest do
  use Pluto.ModelCase

  alias Pluto.User

  @valid_attrs %{email: "some content", password_digest: "some content", reference_id: "some content", role: "some content", sessionid: "some content", status: "some content", username: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
