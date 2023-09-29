defmodule Agrinomicon.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :password_hash, :string
      add :organization_id, references(:organizations, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:users, [:email])
    create index(:users, [:organization_id])
  end
end
