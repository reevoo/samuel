ExUnit.start(
  formatters: [ShouldI.CLIFormatter]
)

defmodule Samuel.TestHelpers.API do
  use Plug.Test
  alias Samuel.API

  @opts API.init([])

  def request(method, path, args \\ "")

  def request(:post, path, args) do
    args = Poison.Encoder.encode(args, []) |> to_string
    conn(:post, path, args)
    |> put_req_header("content-type", "application/json")
    |> API.call(@opts)
  end

  def request(method, path, args) do
    conn(method, path, args)
    |> API.call(@opts)
  end
end
