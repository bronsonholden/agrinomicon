defmodule AgrinomiconWeb.ClassificationsLiveTest do
  use AgrinomiconWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "shows classifications", %{conn: conn} do
    {:ok, _live_view, html} = live(conn, ~p"/classifications")

    assert html
  end
end
