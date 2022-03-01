defmodule FiboWeb.Router do
  use FiboWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", FiboWeb do
    pipe_through :api

    get "/fibonacci", FibonacciController, :list
    get "/fibonacci/:number", FibonacciController, :show
    get "/fibonacci/nth/:number", FibonacciController, :nth

    get "/blacklist", BlacklistController, :list
    post "/blacklist/:number", BlacklistController, :create
    delete "/blacklist/:number", BlacklistController, :remove
  end
end
