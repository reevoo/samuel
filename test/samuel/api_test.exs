defmodule Samuel.APITest do
  use ShouldI
  use Plug.Test
  import ShouldI.Matchers.Plug
  alias Samuel.API

  @opts API.init([])

  defp request(method, path) do
    conn(method, path) |> API.call(@opts)
  end

  with "get /status" do
    setup context do
      %{
        connection: request(:get, "/status")
      }
    end
    should_respond_with :success
    should_match_body_to "We're ok."
  end

  with "non matching endpoint" do
    setup context do
      %{
        connection: request(:get, "/what-is-this?")
      }
    end
    should_respond_with :missing
  end

  with "post /hook" do
    setup context do
      %{
        connection: request(:post, "/hook")
      }
    end
    should_respond_with :success
    should_match_body_to "Thanks."
  end
end
