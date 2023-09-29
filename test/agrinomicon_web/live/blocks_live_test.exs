defmodule AgrinomiconWeb.BlocksLiveTest do
  use AgrinomiconWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "shows blocks", %{conn: conn} do
    {:ok, _live_view, html} = live(conn, ~p"/blocks")

    assert html
  end
end
