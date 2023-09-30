defmodule AgrinomiconWeb.ClassificationLive do
  use AgrinomiconWeb, :live_view

  alias Agrinomicon.Taxonomy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _uri, socket) do
    socket = load_classification(socket, id)

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.link navigate={~p"/classifications"}>
      <.icon name="hero-arrow-left-mini" /> All Classifications
    </.link>
    <.form for={@form} phx-submit="update_classification">
      <.input field={@form[:binomial_name]} label="Binomial name" />
      <.input field={@form[:common_names]} multiple label="Common name" />
      <.input field={@form[:cdl_value]} label="CDL Value" />
      <.input field={@form[:geometry_color]} label="Geometry color" />
      <.button type="submit">Update</.button>
    </.form>
    """
  end

  @impl true
  def handle_event("update_classification", %{"classification" => params}, socket) do
    socket =
      with {:ok, classification} <-
             Taxonomy.update_classification(socket.assigns.classification, params) do
        socket
        |> load_classification(classification.id)
        |> put_flash(:info, "Updated #{classification.binomial_name}")
      else
        {:error, _changeset} ->
          put_flash(socket, :error, "Unable to update classification")
      end

    {:noreply, socket}
  end

  defp load_classification(socket, id) do
    classification = Taxonomy.get_classification!(id)

    form =
      classification
      |> Taxonomy.Classification.changeset(%{})
      |> to_form()

    socket
    |> assign(:classification, classification)
    |> assign(:form, form)
  end
end
