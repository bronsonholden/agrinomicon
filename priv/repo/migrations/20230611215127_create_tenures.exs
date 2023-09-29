defmodule Agrinomicon.Repo.Migrations.CreateTenures do
  use Ecto.Migration

  def change do
    create table(:tenures, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :occupied_at, :utc_datetime
      add :block_id, references(:blocks, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:tenures, [:block_id])
  end
end
