defmodule AgrinomiconWeb.DashboardLive do
  use AgrinomiconWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, push_navigate(socket, to: ~p"/blocks")}
  end

  @impl true
  def render(assigns) do
    ~H"""

    """
  end
end
