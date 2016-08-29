defmodule Pluto.User do
  use Pluto.Web, :model

  schema "users" do
    field :username, :string
    field :email, :string
    field :password_digest, :string
    field :status, :string
    field :reference_id, :string
    field :role, :string
    field :sessionid, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :email, :password_digest, :status, :reference_id, :role, :sessionid])
    |> validate_required([:username, :email, :password_digest, :status, :reference_id, :role, :sessionid])
  end
end
