defmodule Pluto.Comment do
  use Pluto.Web, :model

  schema "comments" do
    field :value, :string
    belongs_to :ticket, Pluto.Ticket

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:value])
    |> validate_required([:value])
  end
end
