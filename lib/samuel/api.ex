defmodule Samuel.API do
  @moduledoc """
  Thin API layer on top of our application.
  
  Does nothing other an recieve github webhooks and replies to status queries.
  """

  use Plug.Router
  alias Samuel.Hook

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch


  post "/hook" do
    case Hook.register(conn.body_params) do
      :ok ->
        send_resp(conn, 200, "Thanks.")
      :unknown_action ->
        send_resp(conn, 400, "Unknown action: #{conn.body_params["action"]}")
    end
  end

  get "/status" do
    send_resp(conn, 200, "We're ok.")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
