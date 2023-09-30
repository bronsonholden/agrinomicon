defmodule AgrinomiconWeb.ClassificationsLive do
  use AgrinomiconWeb, :live_view

  alias Agrinomicon.Taxonomy

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, :classifications, Taxonomy.list_classifications())

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.link navigate={~p"/classifications/new"}>New</.link>
    <table>
      <thead>
        <tr>
          <th class="px-2 text-left">Name</th>
          <th class="px-2 text-left">Binomial name</th>
        </tr>
      </thead>
      <tbody>
        <tr :for={classification <- @classifications}>
          <td class="px-2">
            <.link navigate={~p"/classifications/#{classification.id}"}>
              <%= display_name(classification) %>
            </.link>
          </td>
          <td class="italic px-2"><%= classification.binomial_name %></td>
        </tr>
      </tbody>
    </table>
    """
  end

  @spec display_name(%Taxonomy.Classification{}) :: String.t()
  defp display_name(classification) do
    case classification.common_names do
      nil ->
        classification.binomial_name

      names ->
        names
        |> Enum.at(0)
        |> String.capitalize()
    end
  end
end
