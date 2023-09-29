defmodule Agrinomicon.Taxonomy.Variety do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "varieties" do
    field :denomination, :string
    belongs_to :classification, Agrinomicon.Taxonomy.Classification

    timestamps()
  end

  @doc false
  def changeset(variety, attrs) do
    variety
    |> cast(attrs, [:denomination])
    |> validate_required([:denomination])
    |> assoc_constraint(:classification)
  end
end
