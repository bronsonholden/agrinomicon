defmodule AgrinomiconWeb.NewClassificationLive do
  use AgrinomiconWeb, :live_view

  alias Agrinomicon.Taxonomy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :form, to_form(%{}))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.form for={@form} phx-submit="create_classification">
      <.input field={@form[:kingdom]} label="Kingdom" />
      <.input field={@form[:genus]} label="Genus" />
      <.input field={@form[:species]} label="Species" />
      <.input field={@form[:binomial_name]} label="Binomial name" />
      <.input field={@form[:common_names]} multiple label="Common name" />
      <.input field={@form[:cdl_value]} label="CDL Value" />
      <.input field={@form[:geometry_color]} label="Geometry color" />
      <.button type="submit">Create</.button>
    </.form>
    """
  end

  @impl true
  def handle_event("create_classification", params, socket) do
    socket =
      with {:ok, classification} <- Taxonomy.create_classification(params) do
        socket
        |> put_flash(:info, "Created #{classification.binomial_name}")
        |> push_navigate(to: ~p"/classifications/#{classification.id}")
      else
        {:error, _changeset} ->
          put_flash(socket, :error, "Unable to create classification")
      end

    {:noreply, socket}
  end
end
