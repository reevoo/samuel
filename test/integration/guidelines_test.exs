defmodule Samuel.Integration.GuidelinesTest do
  use ShouldI, async: false # :'(
  import Mock

  alias Samuel.TestHelpers.API

  with "a pull request is opened" do
    setup context do
      mocks = [
        get!:  fn(_)       -> "These are our guidelines." end,
        post!: fn(_, _, _) -> "Thanks." end,
      ]
      event = %{
        "action" => "opened",
        "pull_request" => %{
          "repository" => %{
            "full_name" => "reevoo/samuel",
          },
          "number" => "1",
        },
      }
      %{ mocks: mocks, event: event }
    end

    should "post the guidelines to the pull request", context do
      with_mock HTTPoison, context.mocks do
        API.request(:post, "/hook", context.event)

        x = "{\"body\":\"Guidelines, mofo. Read them.\\n\\n"
          <> "Our guidelines will go here.\\n\"}"
        assert called HTTPoison.post!(
          "https://api.github.com/repos/reevoo/samuel/issues/1/comments",
          %{ "Authorization" => "token TEST-GITHUB-ACCESS-KEY" },
          x
        )
      end
    end

  end
end
