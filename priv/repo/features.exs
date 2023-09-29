with {:ok, body} <- File.read("priv/data/california_counties.geojson"),
     {:ok, geojson} <- Jason.decode(body),
     %{"features" => features, "type" => "FeatureCollection"} <- geojson do
  now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
  Agrinomicon.Repo.insert_all(
    Agrinomicon.GIS.Feature,
    features
    |> Enum.map(fn feature -> %{geometry: Geo.JSON.decode!(feature), inserted_at: now, updated_at: now} end)
  )
else
  _ -> :error
end
