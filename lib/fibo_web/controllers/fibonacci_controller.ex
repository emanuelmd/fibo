defmodule FiboWeb.FibonacciController do
  use FiboWeb, :controller

  alias Fibo.{Fibonacci, Blacklist}

  def nth(conn, %{"number" => number}) do
    with {:parsing, {n, ""}} <- {:parsing, Integer.parse(number)},
         {:nth, n} <- {:nth, Fibonacci.nth(n)},
	 {:blacklist, false} <- {:blacklist, Blacklist.exists?(n)} do
      text(conn, n)
    else
      _ -> put_status(conn, 404) |> text(nil)
    end
  end
end
