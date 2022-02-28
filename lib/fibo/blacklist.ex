defmodule Fibo.Blacklist do

  use Ecto.Schema

  import Ecto.Query

  alias Fibo.{Fibonacci, Blacklist, Repo}
  alias Ecto.Changeset

  # Schema definition

  @primary_key nil

  schema "fibo_blacklist" do
    field :number, :integer
  end

  def create_changeset(n) do
    %Blacklist{}
    |> Changeset.cast(%{"number" => n}, [:number])
    |> Changeset.unique_constraint(:number)
    |> validate_is_fibonacci()
  end

  defp validate_is_fibonacci(changeset) do
    Changeset.validate_change(changeset, :number, fn :number, n ->
      if not Fibonacci.fibonacci?(n) do
	[number: "Provided number is not a fibonacci number"]
      else
	[]
      end
    end)
  end

  def remove_changeset(n) do
    %Blacklist{}
    |> Changeset.cast(%{"number" => n}, [:number])
    |> validate_is_fibonacci()
  end

  # Repo definition

  def exists?(n) do
    Repo.exists?(from(entry in Blacklist, where: entry.number == ^n))
  end

  def add(cs = %Ecto.Changeset{valid?: false}), do: cs
  def add(cs = %Ecto.Changeset{valid?: true}), do: Repo.insert(cs)

  def remove(n) do
  end
end
