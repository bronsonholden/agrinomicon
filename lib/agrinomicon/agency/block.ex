defmodule Agrinomicon.Agency.Block do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "blocks" do
    field :name, :string
    belongs_to :organization, Agrinomicon.Agency.Organization
    belongs_to :feature, Agrinomicon.GIS.Feature
    has_many :tenures, Agrinomicon.Production.Tenure, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(block, attrs) do
    block
    |> cast(attrs, [:name, :feature_id])
    |> cast_assoc(:feature)
    |> cast_assoc(:tenures, with: &Agrinomicon.Production.Tenure.changeset/2)
    |> unique_constraint(:feature_id)
  end
end
