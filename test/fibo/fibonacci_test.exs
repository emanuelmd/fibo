defmodule FibonacciTest do

  use ExUnit.Case, async: true

  alias Fibo.Fibonacci

  test "getting a specific number by index" do

    cases = [
      {0, 0},
      {1, 1},
      {5, 5},
      {13, 7},
      {514229, 29},
      {6765, 20},
      {233, 13}
    ]

    Enum.each(cases, fn {value, idx} -> assert(Fibonacci.nth(idx) == value) end)
  end

  test "generating a stream of fibonacci numbers" do
    items = Fibonacci.stream() |> Enum.take(10) |> Enum.to_list()
    assert items == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  end

  test "if a number is part of the fibonacci sequence" do
    [1, 55, 144, 12586269025]
    |> Enum.each(fn n -> assert Fibonacci.fibonacci?(n) end)

    [99, 4, 202, 145, 733]
    |> Enum.each(fn n -> assert not Fibonacci.fibonacci?(n) end)
  end
end
