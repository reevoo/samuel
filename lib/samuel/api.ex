defmodule Samuel.API do
  @moduledoc """
  Thin API layer on top of our application.

  Does nothing other an recieve github webhooks and replies to status queries.

  /hook Responds to Github hook events.
  See https://developer.github.com/v3/activity/events/types/ for types.
  """

  alias Samuel.Checks
  alias Samuel.DataProvider
  alias Samuel.Dispatchers

  use Plug.Router

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  post "/hook" do
    event  = conn.body_params
    checks = event |> Checks.suitable_checks
    data   = checks |> DataProvider.resolve_requirements(event)

    Checks.perform_checks(checks, data)
    |> Dispatchers.perform_actions!
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
