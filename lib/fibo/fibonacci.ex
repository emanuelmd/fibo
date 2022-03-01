defmodule Fibo.Fibonacci do
  @moduledoc """
  A module that implements utilities around generating fibonacci numbers.
  """

  @doc """
  An infinite stream that generates fibonacci numbers
  """
  def stream do
    Stream.unfold({0, 1}, fn
      {prev, current} -> {prev, {current, current + prev}}
    end)
  end
  
  defp first(stream) do
    stream
    |> Stream.take(1)
    |> Enum.at(0)
  end

  def nth(nth) do
    stream
    |> Stream.drop(nth)
    |> first()
  end

  def fibonacci?(number) when is_integer(number) do
    fibo_number =
      stream()
      |> Stream.drop_while(&(&1 < number))
      |> first()

    fibo_number == number
  end
end
