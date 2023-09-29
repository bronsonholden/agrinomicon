defmodule AgrinomiconWeb.USDACDL.UpdateBlockTenures do
  alias Agrinomicon.Agency
  alias Agrinomicon.Taxonomy

  use Oban.Worker, queue: :default

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"block_id" => block_id}}) do
    update_block_tenures_from_usda(block_id)
  end

  @doc """
  Samples the given Block's geometry in the USDA CDL and update it with full-year
  tenures.

  ## Examples

      iex> update_block_tenures_from_usda(block_id)
      {:ok, %Block{}}

      iex> update_block_tenures_from_usda(block_id)
      {:error, %Ecto.Changeset{}}

  """
  def update_block_tenures_from_usda(block_id) do
    block = Agency.get_block!(block_id, preloads: [:feature, :tenures])

    ranges =
      Enum.map(2010..2022, fn year ->
        {
          DateTime.new!(~D[1900-01-01], ~T[00:00:00.000], "Etc/UTC") |> Map.put(:year, year),
          DateTime.new!(~D[1900-12-31], ~T[23:59:59.999], "Etc/UTC") |> Map.put(:year, year)
        }
      end)

    tenures_attrs =
      Enum.map(ranges, fn {start_date_time, end_date_time} ->
        Task.async(fn -> sampled_tenure_for_block(block, start_date_time, end_date_time) end)
      end)
      |> Task.await_many(10000)
      |> Enum.filter(& &1)

    {:ok, block} = Agency.update_block(block, %{tenures: tenures_attrs})

    Phoenix.PubSub.broadcast(Agrinomicon.PubSub, "blocks", {:update_blocks, [block.id]})
  end

  @doc """
  Generates a tenure from USDA CDL samples for the given block's geometry
  during the given time range.
  """
  def sampled_tenure_for_block(block, start_date_time, end_date_time) do
    {:ok, samples_json} =
      get_usda_samples_for_polygon(
        block.feature.geometry,
        start_date_time |> DateTime.to_unix(:millisecond),
        end_date_time |> DateTime.to_unix(:millisecond)
      )

    distributions = generate_distributions_for_samples(samples_json)

    %{
      occupied_at: start_date_time,
      distributions: distributions
    }
  end

  @base_path "https://pdi.scinet.usda.gov/image/rest/services/CDL_WM/ImageServer"

  # Send a `getSamples` request to the USDA CDL REST API for the given geometry
  # during the given time range.

  # Returns the unaltered JSON response body as a map if successful. Returns `:error`
  # otherwise.
  defp get_usda_samples_for_polygon(geometry, start_unix_time, end_unix_time) do
    query =
      query_params_for_geometry(
        geometry,
        start_unix_time,
        end_unix_time
      )

    request = Finch.build(:get, "#{@base_path}/getSamples?#{query}")
    {:ok, response} = Finch.request(request, Agrinomicon.Finch)
    %{body: body, status: 200} = response
    Jason.decode(body)
  end

  # Returns a list of distributions generated from samples returned by the
  # USDA CDL `getSamples` endpoint. Ignores samples for a crop that cannot
  # be matched to a `Taxonomy.Classification` by its `cdl_value` attribute.
  defp generate_distributions_for_samples(%{"samples" => samples}) do
    counts = Enum.frequencies_by(samples, &Map.fetch!(&1, "value"))
    total_samples = Map.values(counts) |> Enum.sum()

    coverages =
      for {key, value} <- counts, into: [], do: {key, trunc(value / total_samples * 100)}

    Enum.map(coverages, fn {cdl_value, coverage} ->
      with cls when not is_nil(cls) <- Taxonomy.get_classification_by_cdl_value(cdl_value) do
        %{classification_id: cls.id, coverage: coverage}
      else
        _ -> nil
      end
    end)
    |> Enum.filter(& &1)
  end

  # Helper to generate query parameters for the USDA CDL `getSamples` endpoint.
  defp query_params_for_geometry(geometry, start_unix_time, end_unix_time) do
    coordinates = Geo.JSON.encode!(geometry) |> Map.fetch!("coordinates")

    URI.encode_query(%{
      "geometry" =>
        """
          {
            rings: #{Jason.encode!(coordinates)},
            spatialReference: {
              wkid: 4326
            }
          }
        """
        |> String.replace(~r/\s+/, ""),
      "f" => "json",
      "sampleCount" => 100,
      "geometryType" => "esriGeometryPolygon",
      "time" => "#{start_unix_time},#{end_unix_time}",
      "interpolation" => "RSP_NearestNeighbor"
    })
  end
end
