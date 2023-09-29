defmodule Agrinomicon.Repo.Migrations.CreateVarieties do
  use Ecto.Migration

  def change do
    create table(:varieties, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :denomination, :string

      add :classification_id,
          references(:classifications, on_delete: :nothing, type: :binary_id, null: false)

      timestamps()
    end

    create index(:varieties, [:classification_id])
  end
end
