defmodule AgrinomiconWeb.DashboardLiveTest do
  use AgrinomiconWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "shows dashboard", %{conn: conn} do
    result =
      live(conn, ~p"/")
      |> follow_redirect(conn, ~p"/blocks")

    {:ok, _live_view, html} = result

    assert html
  end
end
