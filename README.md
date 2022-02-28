# Fibo

## Prerequisits

  * Have postgres up and running
  * Elixir version 1.12

## Running the server

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Running tests

  * Install dependencies wtih `mix deps.get`
  * Run tests using `mix test`

# API endpoints

  * `GET    /api/fibonacci/nth/:number` -> Retreives the nth fibonacci number from the sequence
  * `GET    /api/fibonacci/:number`     -> Returns 200 and no body if the number is a fibonacci number and it's not blacklisted (otherwise 404)
  * `GET    /api/blacklist`             -> Retrieves the blacklist
  * `POST   /api/blacklist/:number`     -> Adds a fibonacci number to the blacklist.
  * `DELETE /api/blacklist/:number`     -> Removes a fibonacci number from the blacklist

