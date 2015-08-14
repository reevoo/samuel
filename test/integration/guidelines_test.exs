defmodule Samuel.Integration.GuidelinesTest do
  use ShouldI, async: false # :'(
  import Mock

  alias Samuel.TestHelpers.API

  with "a pull request is opened" do
    setup context do
      mocks = [
        get!:  fn(_, _)    -> %{
          body: "These are our guidelines.",
          headers: %{"Content-Type" => "text/plain"}
        } end,
        post!: fn(url, _, headers) ->
          assert url == "https://api.github.com/repos/reevoo/samuel/issues/1/comments"
          assert headers == [{"Authorization", "token DUMMY-GITHUB-ACCESS-KEY"}]
        end,
      ]
      event = %{
        "action" => "opened",
        "pull_request" => %{
          "number" => "1",
        },
        "repository" => %{
          "full_name" => "reevoo/samuel",
        },
      }
      %{ mocks: mocks, event: event }
    end

    should "post the guidelines to the pull request", context do
      with_mock HTTPoison, context.mocks do
        API.request(:post, "/hook", context.event)
        # Expectations defined in the mock.
      end
    end

  end
end
