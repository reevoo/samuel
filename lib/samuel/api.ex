defmodule Samuel.API do
  @moduledoc """
  Thin API layer on top of our application.

  Does nothing other an recieve github webhooks and replies to status queries.
  """

  use Plug.Router
  alias Samuel.Checks

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  post "/hook" do
    params = conn.body_params
    params
    |> Checks.checks_for
    |> Enum.map(fn(x) -> x.check(params) end)
    |> Enum.filter(&(&1)) # Strip nils
    # Do the shit.
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
