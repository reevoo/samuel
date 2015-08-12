defmodule Samuel.Dispatchers.GithubTest do
  use ShouldI, async: false
  import Mock

  alias Samuel.Action
  alias Samuel.Dispatchers.Github

  with "post comment action" do
    setup context do
      Dict.put context, :actions, [%Action{
        action: :post_comment,
        repo: "REPO",
        pull_id: 123,
        message: "Hello, world!"
      }]
    end

    should "send a POST request to the correct GitHub URL", context do
      with_mock HTTPoison, [post!: fn(_, _, a) -> nil end] do
        Github.process_actions(context.actions)

        assert called HTTPoison.post!(
          "https://api.github.com/repos/REPO/issues/123/comments",
          %{
            "Authorization" => "token TEST-GITHUB-ACCESS-KEY"
          },
          "{\"body\":\"Hello, world!\"}"
        )
      end
    end

  end


end
