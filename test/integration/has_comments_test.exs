defmodule Samuel.Integration.HasCommentsTest do
  use ShouldI, async: false # :'(
  import Mock

  alias Samuel.TestHelpers.API

  with "a pull request is closed" do

    setup context do
      event = %{
        "action" => "closed",
        "pull_request" => %{
          "merged" => true,
          "repository" => %{
            "full_name" => "reevoo/samuel",
          },
          "number" => "1",
          "user" => %{
            "login" => "AUTHOR"
          }
        },
      }
      %{ event: event }
    end

    with "no comments" do

      setup context do
        Dict.put(context, :mocks, [
          get!: fn(_, _) -> %{ body: "[]" } end,
          post!: fn(_, _, _) -> nil end,
        ])
      end

      should "post a comment complaining about a lack of review", context do
        with_mock HTTPoison, context.mocks do
          API.request(:post, "/hook", context.event)

          x = "{\"body\":\"I don't see any comments on your Pull Request.\\n\\n"
          <> "Are you too good for code reviews now?\\nNo. No you aren't.\\n\\n"
          <> "Maybe you forgot to say who reviewed it. That's fine, but let me know.\\n\"}"

          assert called HTTPoison.post!(
            "https://api.github.com/repos/reevoo/samuel/issues/1/comments",
            %{ "Authorization" => "token TEST-GITHUB-ACCESS-KEY" },
            x
          )
        end
      end

    end

    with "comments from other users" do

      setup context do
        Dict.put(context, :mocks, [
          get!: fn(_, _) -> %{ body: ~s([{"user": {"login": "SOMEONE"}}]) } end,
          post!: fn(_, _, _) -> nil end,
        ])
      end

      should "not post a comment", context do
        with_mock HTTPoison, context.mocks do

          API.request(:post, "/hook", context.event)

          x = "{\"body\":\"I don't see any comments on your Pull Request.\\n\\n"
          <> "Are you too good for code reviews now?\\nNo. No you aren't.\\n\\n"
          <> "Maybe you forgot to say who reviewed it. That's fine, but let me know.\\n\"}"

          assert not called HTTPoison.post!(
            "https://api.github.com/repos/reevoo/samuel/issues/1/comments",
            %{ "Authorization" => "token TEST-GITHUB-ACCESS-KEY" },
            x
          )
        end
      end

    end

  end
end
