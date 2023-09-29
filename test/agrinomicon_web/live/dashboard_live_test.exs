defmodule AgrinomiconWeb.DashboardLiveTest do
  use AgrinomiconWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "shows dashboard", %{conn: conn} do
    {:ok, _live_view, html} = live(conn, ~p"/")

    assert html
  end
end
