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

## API endpoints

  * `GET    /api/fibonacci?after=20&count=50` -> Returns a json 
  * `GET    /api/fibonacci/:number`           -> Returns 200 and no body if the number is a fibonacci number and it's not blacklisted (otherwise 404)
  * `GET    /api/fibonacci/nth/:number`       -> Retreives the nth fibonacci number from the sequence
  * `GET    /api/blacklist`                   -> Retrieves the blacklist
  * `POST   /api/blacklist/:number`           -> Adds a fibonacci number to the blacklist.
  * `DELETE /api/blacklist/:number`           -> Removes a fibonacci number from the blacklist

## Technical consideration

* The numbers contained within the blacklist table are saved as strings because they are extremely large and don't fit into any Postgres's integer types.
* When fetching a fibonacci list the max count you can request is 100. I chose this arbitrary number as a performance consideration, so one request doesn't hog too much computational power and also to avoid infinite loops
* When fetching just one number or the nth number, there's only text response or no response at all, I think this makes a lot of sense considering there's just one number returned. Could be parametrized to json or other formats

