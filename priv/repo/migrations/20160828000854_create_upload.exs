defmodule Pluto.Repo.Migrations.CreateUpload do
  use Ecto.Migration

  def change do
    create table(:uploads) do
      add :s3_url, :string
      add :type, :string
      add :type_id, :integer

      timestamps()
    end

    create unique_index(:uploads, [:s3_url])
  end
end
