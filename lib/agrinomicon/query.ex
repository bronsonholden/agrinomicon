defmodule Agrinomicon.Query do
  alias Agrinomicon.Repo
  alias Agrinomicon.{Agency, GIS, Production, Taxonomy}

  import Ecto.Query
  import Geo.PostGIS

  def ordered_distributions_query() do
    from(d in Production.Distribution,
      left_join: c in Taxonomy.Classification,
      on: d.classification_id == c.id,
      order_by: [desc: d.coverage, desc: fragment("?[0]", c.common_names)],
      preload: :classification
    )
  end

  def ordered_tenures_query() do
    distributions = ordered_distributions_query()

    from(t in Production.Tenure,
      order_by: [desc: t.occupied_at],
      preload: [distributions: ^distributions]
    )
  end

  @doc """
  Returns a query for blocks near the given point with preloaded production
  information: tenures ordered in descending occupation date, with distributions
  ordered from greatest to least crop coverage, then by first common name.
  """
  def blocks_with_production_near_query(lng, lat) do
    x = String.to_float(lng)
    y = String.to_float(lat)

    tenures = ordered_tenures_query()

    from b in Agency.Block,
      join: f in GIS.Feature,
      on: b.feature_id == f.id,
      # TODO: Bounding box? Order by distance from camera + 1k limit?
      where: st_distance(st_centroid(f.geometry), st_point(^x, ^y)) < 0.3,
      preload: [
        :feature,
        tenures: ^tenures
      ]
  end

  @spec blocks_with_production_near(String.t(), String.t()) :: [%Agency.Block{}]
  def blocks_with_production_near(lng, lat) do
    blocks_with_production_near_query(lng, lat)
    |> Repo.all()
  end

  @spec block_with_production(String.t()) :: %Agency.Block{} | term() | nil
  def block_with_production(id) do
    tenures = ordered_tenures_query()
    query = from b in Agency.Block, preload: [:feature, tenures: ^tenures]

    Repo.get(query, id)
  end
end
