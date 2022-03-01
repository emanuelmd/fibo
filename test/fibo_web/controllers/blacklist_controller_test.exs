defmodule FiboWeb.BlacklistControllerTest do

  use FiboWeb.ConnCase

  alias Fibo.Blacklist

  test "blacklisting fibonacci numbers", %{conn: conn} do
    result = post(conn, Routes.blacklist_path(conn, :create, "55"))
    |> response(201)

    assert Enum.member?(Blacklist.list(), 55)
  end

  test "removing a number from blacklist", %{conn: conn} do
    Blacklist.create_changeset(5) |> Blacklist.add()

    assert Enum.member?(Blacklist.list(), 5)

    result = delete(conn, Routes.blacklist_path(conn, :remove, "5"))
    |> response(204)

    refute Enum.member?(Blacklist.list(), 5)
  end

  test "non-fibonacci numbers are not added to the blacklist", %{conn: conn} do
    assert Blacklist.list() |> Enum.empty?()

    post(conn, Routes.blacklist_path(conn, :create, "54"))
    |> response(400)

    assert Blacklist.list() |> Enum.empty?()
  end

  test "fetching the blacklist", %{conn: conn} do

    numbers = [1, 5, 13, 55]

    Enum.each(
      numbers,
      fn n -> Blacklist.create_changeset(n) |> Blacklist.add() end
    )

    result = get(conn, Routes.blacklist_path(conn, :list))
    |> json_response(200)

    assert Enum.count(result["numbers"]) == 4

    Enum.each(
      result["numbers"],
      fn n -> assert Enum.member?(numbers, n) end
    )
  end
end
