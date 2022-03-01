defmodule Fibo.Blacklist do
  use Ecto.Schema

  import Ecto.Query

  alias Fibo.{Fibonacci, Blacklist, Repo}
  alias Ecto.Changeset

  # Schema definition

  @primary_key nil

  schema "fibo_blacklist" do
    field :number, :string
  end

  def create_changeset(n) when is_integer(n) do
    create_changeset(to_string(n))
  end

  def create_changeset(n) do
    %Blacklist{}
    |> Changeset.cast(%{"number" => n}, [:number])
    |> Changeset.unique_constraint(:number)
    |> validate_is_number()
    |> validate_is_fibonacci()
  end

  defp validate_is_fibonacci(changeset) do
    Changeset.validate_change(changeset, :number, fn :number, n ->
      with {n, ""} <- Integer.parse(n),
           true <- Fibonacci.fibonacci?(n) do
        []
      else
        _ -> [number: "Provided number is not part of the fibonacci"]
      end
    end)
  end

  defp validate_is_number(changeset) do
    Changeset.validate_change(changeset, :number, fn :number, number ->
      case Regex.run(~r/^\d+$/, number) do
        [_] -> []
        _ -> [number: "Please provide a number as a string"]
      end
    end)
  end

  def remove_changeset(n) do
    %Blacklist{}
    |> Changeset.cast(%{"number" => n}, [:number])
    |> validate_is_fibonacci()
  end

  # Repo definition

  def exists?(n) when is_integer(n) do
    query = from entry in Blacklist, where: entry.number == ^to_string(n)
    Repo.exists?(query)
  end

  def list do
    Repo.all(from b in Blacklist, select: b.number)
    |> Enum.map(&String.to_integer/1)
    |> MapSet.new()
  end

  def add(cs = %Ecto.Changeset{valid?: false}), do: cs
  def add(cs = %Ecto.Changeset{valid?: true}), do: Repo.insert(cs)

  def remove(_n) do
  end
end
