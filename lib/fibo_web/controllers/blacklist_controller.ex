defmodule FiboWeb.BlacklistController do

  use FiboWeb, :controller

  alias Fibo.Blacklist

  def create(conn, %{"number" => number}) do

    cs = Blacklist.create_changeset(number)

    if cs.valid? do

      Blacklist.add(cs)

      put_status(conn, 201)
      |> text(nil)
    else

      error_message = Ecto.Changeset.traverse_errors(cs, fn {msg, _} -> msg end)[:number] |> Enum.join("; ")

      put_status(conn, 400)
      |> text(error_message)
    end
  end

  def list(conn, _) do
    json(conn, %{"numbers" => Blacklist.list() |> Enum.to_list()})
  end

  def remove(conn, %{"number" => number}) do
    Blacklist.remove(number)

    put_status(conn, 204)
    |> text(nil)
  end
end
