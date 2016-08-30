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

  @required_fields ~w(username email password_digest)
  @optional_fields ~w(status reference_id role sessionid)
  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end
end
