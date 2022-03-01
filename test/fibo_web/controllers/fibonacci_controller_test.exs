defmodule FiboWeb.FibonacciControllerTest do

  use FiboWeb.ConnCase

  alias Fibo.Blacklist

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

    # Blacklist number 13 which is on the 7th position
    Blacklist.create_changeset("13") |> Blacklist.add()

    get(conn, Routes.fibonacci_path(conn, :nth, "7"))
    |> response(404)
  end

  test "fetching a segment of the list", %{conn: conn} do

    result = get(conn, Routes.fibonacci_path(conn, :list))
    |> json_response(200)

    assert Enum.count(result["numbers"]) == 100
  end

  test "fetching a segment of the list won't include blacklisted numbers", %{conn: conn} do

    blacklist = [13, 5, 55]

    Enum.each(
      blacklist,
      fn b -> Blacklist.create_changeset(b) |> Blacklist.add() end
    )

    %{"numbers" => numbers} = get(conn, Routes.fibonacci_path(conn, :list), %{"count" => "15"})
    |> json_response(200)

    Enum.each(numbers, fn numb -> assert not Enum.member?(blacklist, numb) end)

    assert Enum.count(numbers) == 15
  end
end
