defmodule Pluto.Repo.Migrations.CreateTicket do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :subject, :string
      add :description, :string

      timestamps()
    end

  end
end
