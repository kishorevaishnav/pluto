defmodule Pluto.Upload do
  use Pluto.Web, :model

  schema "uploads" do
    field :s3_url, :string
    field :type, :string
    field :type_id, :integer

    timestamps()
  end

  @required_fields ~w(s3_url type type_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    # |> validate_required([:s3_url, :type, :type_id])
  end
end
