defmodule Agrinomicon.Production.Distribution do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "distributions" do
    field :coverage, :float
    belongs_to :tenure, Agrinomicon.Production.Tenure
    belongs_to :variety, Agrinomicon.Taxonomy.Variety
    belongs_to :classification, Agrinomicon.Taxonomy.Classification

    timestamps()
  end

  @doc false
  def changeset(distribution, attrs) do
    distribution
    |> cast(attrs, [:coverage, :tenure_id, :variety_id, :classification_id])
    |> validate_number(:coverage, greater_than: 0, less_than_or_equal_to: 100)
  end
end
