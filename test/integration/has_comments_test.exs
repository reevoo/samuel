defmodule Samuel.Integration.HasCommentsTest do
  use ShouldI, async: false # :'(
  import Mock

  alias Samuel.TestHelpers.API

  having "a pull request is closed" do

    setup context do
      event = %{
        "action" => "closed",
        "pull_request" => %{
          "merged" => true,
          "user" => %{
            "login" => "AUTHOR"
          },
          "comments_url" => "COMMENTS-URL"
        }
      }
      %{ event: event }
    end

    having "no comments" do

      setup context do
        Dict.put(context, :mocks, [
          get!: fn(_, _) -> %{
            body: "[]",
            headers: [{"Content-Type", "application/json"}]
          } end,
          post!: fn(url, _, headers) ->
            assert url == "COMMENTS-URL"
            assert headers == [
              {"Authorization", "token DUMMY-GITHUB-ACCESS-KEY"}
            ]
          end,
        ])
      end

      should "post a comment complaining about a lack of review", context do
        with_mock HTTPoison, context.mocks do
          API.request(:post, "/hook", context.event)
          # Assertions in the mock.
        end
      end

    end

    having "comments from other users" do

      setup context do
        Dict.put(context, :mocks, [
          get!: fn(_, _) ->
            %{
              body: ~s([{"user": {"login": "SOMEONE"}}]),
              headers: [{"Content-Type", "application/json"}]
            }
          end,
          post!: fn(_, _, _) ->
            assert false # We don't want a POST request!
          end,
        ])
      end

      should "not post a comment", context do
        with_mock HTTPoison, context.mocks do
          API.request(:post, "/hook", context.event)
          # Assertions in the mock.
        end
      end

    end

  end
end
