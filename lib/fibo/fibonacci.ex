defmodule Fibo.Fibonacci do

  def stream do
    Stream.unfold({0, 1}, fn
      {prev, current} -> {prev, {current, current + prev}}
    end)
  end

  def first(stream) do
    stream
    |> Stream.take(1)
    |> Enum.at(0)
  end

  def nth(nth) do
    stream
    |> Stream.drop(nth)
    |> first()
  end

  def fibonacci?(number) do
    fibo_number =
      stream()
      |> Stream.drop_while(&(&1 < number))
      |> first()

    fibo_number == number
  end
end
