defmodule Pluto.UploadTest do
  use Pluto.ModelCase

  alias Pluto.Upload

  @valid_attrs %{s3_url: "some content", type: "some content", type_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Upload.changeset(%Upload{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Upload.changeset(%Upload{}, @invalid_attrs)
    refute changeset.valid?
  end
end
