defmodule Agrinomicon.GIS.Feature do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "features" do
    field :geometry, Geo.PostGIS.Geometry
    field :properties, :map

    timestamps()
  end

  @doc false
  def changeset(feature, attrs) do
    feature
    |> cast(attrs, [:geometry, :properties])
    |> validate_required([:geometry])
  end
end
