ExUnit.start(
  formatters: [ShouldI.CLIFormatter]
)

defmodule Samuel.TestHelpers.API do
  use Plug.Test
  alias Samuel.API

  @opts API.init([])

  def request(method, path, args \\ "")

  def request(:post, path, args) do
    args
    |> Poison.Encoder.encode([])
    |> to_string

    connection = conn(:post, path, args)
    connection
    |> put_req_header("content-type", "application/json")
    |> API.call(@opts)
  end

  def request(method, path, args) do
    connection = conn(method, path, args)
    connection
    |> API.call(@opts)
  end
end
