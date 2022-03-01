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

  def show(conn, %{"number" => number}) do
    with {n, ""} <- Integer.parse(number),
         false <- Blacklist.exists?(n),
         true <- Fibonacci.fibonacci?(n) do
      text(conn, number)
    else
      _ -> put_status(conn, 404) |> text(nil)
    end
  end

  defp parse_and_clamp(value, default, predicate) do
    with {n, ""} <- Integer.parse(value),
         true <- predicate.(n) do
      n
    else
      _ -> default
    end
  end

  def parse_params_list(params) do
    aftr =
      parse_and_clamp(
        Map.get(params, "after", "0"),
        0,
        fn n -> n >= 0 end
      )

    count =
      parse_and_clamp(
        Map.get(params, "count", "100"),
        100,
        fn n -> n > 0 and n <= 100 end
      )

    {aftr, count}
  end

  def list(conn, params) do
    {aftr, count} = parse_params_list(params)

    blacklist = Blacklist.list()

    result =
      Fibonacci.stream()
      |> Stream.drop_while(&(&1 < aftr))
      |> Stream.filter(fn el -> not MapSet.member?(blacklist, el) end)
      |> Stream.take(count)
      |> Enum.to_list()

    json(conn, %{"numbers" => result})
  end
end

