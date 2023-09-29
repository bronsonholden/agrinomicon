defmodule Agrinomicon.Repo.Migrations.CreateClassifications do
  use Ecto.Migration

  def change do
    create table(:classifications, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :kingdom, :string
      add :genus, :citext
      add :species, :citext
      add :binomial_name, :string
      add :aliases, {:array, :string}
      add :common_names, {:array, :string}
      add :cdl_value, :string
      add :geometry_color, :string

      timestamps()
    end

    create unique_index(:classifications, [:genus, :species])
    create unique_index(:classifications, :cdl_value)
  end
end
