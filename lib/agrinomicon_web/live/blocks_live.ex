defmodule AgrinomiconWeb.BlocksLive do
  use AgrinomiconWeb, :live_view

  alias Agrinomicon.Agency

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Agrinomicon.PubSub, "blocks")
    end

    socket =
      socket
      |> assign(:edit, false)

    {:ok, socket}
  end

  @impl true
  @spec handle_info(
          {:update_block, list(String.t())},
          Phoenix.LiveView.Socket.t()
        ) :: {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_info({:update_blocks, block_ids}, socket) do
    socket =
      push_event(socket, "insert_features", %{
        features:
          AgrinomiconWeb.EditBlocks.list_blocks_with_production(block_ids)
          |> Enum.map(&feature_for_block/1)
      })

    {:noreply, socket}
  end

  def handle_info({:delete_blocks, block_ids}, socket) do
    socket =
      push_event(socket, "remove_features", %{
        features: Enum.map(block_ids, fn id -> %{id: id} end)
      })

    {:noreply, socket}
  end

  @impl true
  def handle_params(%{"lng" => lng, "lat" => lat}, _url, socket) do
    socket = assign(socket, lng: lng, lat: lat)

    features =
      AgrinomiconWeb.EditBlocks.list_blocks_with_production_near(lng, lat)
      |> Enum.map(&feature_for_block/1)

    socket =
      socket
      |> assign(:lng, lng)
      |> assign(:lat, lat)
      |> push_event("put_features", %{features: features})

    {:noreply, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def feature_for_block(block) do
    %{
      id: block.id,
      type: "Feature",
      geometry: Geo.JSON.encode!(block.feature.geometry),
      properties: properties_for_block(block)
    }
  end

  defp properties_for_block(block) do
    properties =
      Map.put(
        block.feature.properties,
        :tenures,
        Enum.map(block.tenures, fn tenure ->
          %{
            occupied_at: tenure.occupied_at,
            distributions:
              Enum.map(tenure.distributions, fn distribution ->
                %{coverage: distribution.coverage, classification: distribution.classification_id}
              end)
          }
        end)
      )

    with [tenure | _] <- block.tenures do
      case tenure.distributions do
        [] ->
          properties

        distributions ->
          dist =
            Enum.max_by(
              distributions,
              fn %{coverage: coverage} -> coverage end
            )

          Map.put(
            properties,
            :color,
            "##{dist.classification.geometry_color}"
          )
      end
    else
      _ -> properties
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="absolute top-[57px] bottom-0 left-0 right-0 flex flex-col">
      <div
        id="map"
        phx-hook="Map"
        class="h-full"
        phx-update="ignore"
        data-access-token={Application.get_env(:agrinomicon, :mapbox_access_token)}
      >
      </div>

      <div id="blocks-draw" phx-hook="MapDraw" data-map-id="map" />
    </div>
    """
  end

  def handle_event("toggle_edit", _params, socket) do
    {:noreply, assign(socket, :edit, not socket.assigns.edit)}
  end

  @impl true
  def handle_event("update_camera", params, socket) do
    {:noreply, push_patch(socket, to: ~p"/blocks?#{params}")}
  end

  @impl true
  def handle_event("create_blocks", %{"features" => features}, socket) do
    new_blocks = AgrinomiconWeb.EditBlocks.create_blocks(features)
    reply = %{block_ids: Enum.map(new_blocks, fn block -> block.id end)}

    {:reply, reply, socket}
  end

  @impl true
  def handle_event("delete_blocks", %{"block_ids" => block_ids}, socket) do
    AgrinomiconWeb.EditBlocks.delete_blocks(block_ids)

    {:noreply, socket}
  end

  @impl true
  def handle_event("update_blocks", %{"blocks" => blocks}, socket) do
    AgrinomiconWeb.EditBlocks.update_feature_for_blocks(blocks)

    {:noreply, socket}
  end
end
