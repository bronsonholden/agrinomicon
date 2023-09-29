defmodule Agrinomicon.Repo.Migrations.CreateBlocks do
  use Ecto.Migration

  def change do
    create table(:blocks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :feature_id, references(:features, on_delete: :nothing, type: :binary_id)
      add :organization_id, references(:organizations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:blocks, [:feature_id])
    create index(:blocks, [:organization_id])
  end
end
