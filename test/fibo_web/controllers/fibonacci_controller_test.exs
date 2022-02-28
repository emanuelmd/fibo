defmodule FiboWeb.FibonacciControllerTest do

  use FiboWeb.ConnCase

  test "fetching the nth fibonacci number", %{conn: conn} do
    result = get(conn, Routes.fibonacci_path(conn, :nth, "20"))
    |> text_response(200)

    assert result == "6765"
  end

  test "fetching with bogus number param", %{conn: conn} do
    get(conn, Routes.fibonacci_path(conn, :nth, "al0ha"))
    |> response(404)
  end

  test "fetching a blacklisted number", %{conn: conn} do
  end
end
