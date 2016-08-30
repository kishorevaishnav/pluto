defmodule Pluto.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :email, :string
      add :password_digest, :string
      add :status, :string
      add :reference_id, :string
      add :role, :string
      add :sessionid, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])
  end
end
