defmodule Samuel.APITest do
  use ShouldI
  use Plug.Test
  import ShouldI.Matchers.Plug
  alias Samuel.API

  @opts API.init([])

  defp request(method, path, args \\ "")

  defp request(:post, path, args) do
    args = Poison.Encoder.encode(args, []) |> to_string
    conn(:post, path, args)
    |> put_req_header("content-type", "application/json")
    |> API.call(@opts)
  end

  defp request(method, path, args) do
    conn(method, path, args)
    |> API.call(@opts)
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
    with "a known action" do
      setup context do
        %{
          connection: request(:post, "/hook", %{"action" => "ping"})
        }
      end
      should_respond_with :success
      should_match_body_to "Pong!"
    end

    with "an unknown action" do
      setup context do
        %{
          connection: request(:post, "/hook", %{"action" => "magic dancing unicorn"})
        }
      end
      should_respond_with :bad_request
      should_match_body_to "No action for magic dancing unicorn"
    end
  end
end
