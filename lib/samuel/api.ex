defmodule Samuel.API do
  use Plug.Router

  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch


  post "/hook" do
    send_resp(conn, 200, "Thanks.")
  end

  get "/status" do
    send_resp(conn, 200, "We're ok.")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
