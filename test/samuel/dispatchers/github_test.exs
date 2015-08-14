defmodule Samuel.Dispatchers.GithubTest do
  use ShouldI, async: false
  import Mock

  alias Samuel.Action
  alias Samuel.Dispatchers.Github

  with "post comment action" do
    setup context do
      actions = [%Action{
        action: :post_comment,
        repo: "REPO",
        pull_id: 123,
        message: "Hello, world!"
      }]

      mock = [
        post!: fn(url, _, headers) ->
          assert url == "https://api.github.com/repos/REPO/issues/123/comments"
          assert headers == [{ "Authorization", "token DUMMY-GITHUB-ACCESS-KEY" }]
        end
      ]

      %{ actions: actions, mock: mock }
    end

    should "send a POST request to the correct GitHub URL", context do
      with_mock HTTPoison, context.mock do
        Github.process_actions(context.actions)
        # Assertions in mock
      end
    end

  end


end
