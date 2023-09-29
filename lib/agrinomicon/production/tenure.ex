defmodule Agrinomicon.Production.Tenure do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tenures" do
    field :occupied_at, :utc_datetime
    belongs_to :block, Agrinomicon.Agency.Block
    has_many :distributions, Agrinomicon.Production.Distribution, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(tenure, attrs) do
    tenure
    |> cast(attrs, [:occupied_at, :block_id])
    |> cast_assoc(:block)
    |> cast_assoc(:distributions, with: &Agrinomicon.Production.Distribution.changeset/2)
  end
end
