defmodule Pluto.Ticket do
  use Pluto.Web, :model

  schema "tickets" do
    field :subject, :string
    field :description, :string
    has_many :comments, Pluto.Comment

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:subject, :description])
    |> validate_required([:subject, :description])
  end
end
