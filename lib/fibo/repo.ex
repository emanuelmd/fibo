defmodule Fibo.Repo do
  use Ecto.Repo,
    otp_app: :fibo,
    adapter: Ecto.Adapters.Postgres
end
