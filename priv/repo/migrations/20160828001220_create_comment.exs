defmodule Pluto.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :value, :string
      add :ticket_id, references(:tickets, on_delete: :nothing)

      timestamps()
    end
    create index(:comments, [:ticket_id])

  end
end
