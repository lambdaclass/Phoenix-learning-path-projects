defmodule CounterWeb.CounterTest do
  use CounterWeb.ConnCase
  import Phoenix.LiveViewTest

  test "connected mount", %{conn: conn} do
    {:ok, _view, html} = live(conn, "/")
    assert html =~ "Counter: 0"
  end

  test "Increment", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert render_click(view, :inc) =~ "Counter: 1"
  end

  test "Decrement", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert render_click(view, :dec) =~ "Counter: -1"
  end

  test "handle_info/2 broadcast message", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    {:ok, view2, _html} = live(conn, "/")

    assert render_click(view, :inc) =~ "Counter: 1"
    assert render_click(view2, :inc) =~ "Counter: 2"
  end
end
