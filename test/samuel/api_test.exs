defmodule Samuel.APITest do
  use ShouldI
  import ShouldI.Matchers.Plug
  alias Samuel.TestHelpers.API

  with "get /status" do
    setup context do
      %{
        connection: API.request(:get, "/status")
      }
    end
    should_respond_with :success
    should_match_body_to "We're ok."
  end


  with "non matching endpoint" do
    setup context do
      %{
        connection: API.request(:get, "/what-is-this?")
      }
    end
    should_respond_with :missing
  end


  with "post /hook" do
    with "a known action" do
      setup context do
        %{
          connection: API.request(:post, "/hook", %{"action" => "ping"})
        }
      end
      should_respond_with :success
    end

    with "an unknown action" do
      setup context do
        con = API.request(:post, "/hook", %{"action" => "magic unicorn"})
        %{
          connection: con,
        }
      end
      should_respond_with :success
    end
  end
end
