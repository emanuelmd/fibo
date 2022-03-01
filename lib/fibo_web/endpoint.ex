defmodule FiboWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :fibo

  @session_options [
    store: :cookie,
    key: "_fibo_key",
    signing_salt: "w1ZDuYrb"
  ]

  plug Plug.Static,
    at: "/",
    from: :fibo,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :fibo
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug FiboWeb.Router
end
