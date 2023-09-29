defmodule Agrinomicon.Repo.Migrations.CreateFeatures do
  use Ecto.Migration

  def change do
    create table(:features, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :geometry, :geometry, null: false
      add :properties, :map, default: %{}

      timestamps()
    end
  end
end
