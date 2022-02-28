defmodule Fibo.Repo.Migrations.AddBlacklistTable do
  use Ecto.Migration

  def change do
    create table("fibo_blacklist") do
      add :number, :integer
    end

    create index("fibo_blacklist", [:number], unique: true)
  end
end
