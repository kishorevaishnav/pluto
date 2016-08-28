defmodule Pluto.Comment do
  use Pluto.Web, :model
  require Logger

  schema "comments" do
    field :value, :string
    belongs_to :ticket, Pluto.Ticket

    timestamps()
  end

  @required_fields ~w(value ticket_id)
  @optional_fields ~w()

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    Logger.debug inspect(struct)
    Logger.debug "INSPECT params ===== #{inspect(params, pretty: true)}"
    Logger.debug "INSPECT @required_fields ===== #{inspect(@required_fields, pretty: true)}"
    IO.inspect struct

    struct
    |> cast(params, @required_fields, @optional_fields)
    # |> validate_required([:value, :ticket_id])
  end
end
