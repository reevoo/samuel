defmodule Samuel.API do
  @moduledoc """
  Thin API layer on top of our application.

  Does nothing other an recieve github webhooks and replies to status queries.
  """

  use Plug.Router
  alias Samuel.Checks
  alias Samuel.Dispatchers

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  post "/hook" do
    params = conn.body_params
    params
    |> Checks.checks_for # Get checks for event
    |> Enum.map(fn(x) -> x.check(params) end) # Get check results
    |> Enum.filter(&(&1)) # Strip nils (pass)
    |> Dispatchers.process_actions
    |> case do
      [] ->
        send_resp(conn, 200, "No actions.")
      _ ->
        send_resp(conn, 200, "Stuff done.")
    end
  end

  get "/status" do
    send_resp(conn, 200, "We're ok.")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
