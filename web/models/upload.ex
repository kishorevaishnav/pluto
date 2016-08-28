defmodule Pluto.Upload do
  use Pluto.Web, :model

  schema "uploads" do
    field :s3_url, :string
    field :type, :string
    field :type_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:s3_url, :type, :type_id])
    |> validate_required([:s3_url, :type, :type_id])
  end
end
