defmodule Agrinomicon.Repo.Migrations.CreateDistributions do
  use Ecto.Migration

  def change do
    create table(:distributions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :coverage, :float
      add :tenure_id, references(:tenures, on_delete: :delete_all, type: :binary_id)
      add :variety_id, references(:varieties, on_delete: :delete_all, type: :binary_id)

      add :classification_id,
          references(:classifications, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:distributions, [:tenure_id])
    create index(:distributions, [:variety_id])
    create index(:distributions, [:classification_id])
  end
end
