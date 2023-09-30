defmodule AgrinomiconWeb.NewClassificationLiveTest do
  use AgrinomiconWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "shows new classification form", %{conn: conn} do
    {:ok, _live_view, html} = live(conn, ~p"/classifications/new")

    assert html
  end
end
