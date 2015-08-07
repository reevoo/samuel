defmodule Samuel.Dispatchers.GithubTest do
  use ShouldI
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

    @tag :pending
    should "send a POST request to the correct GitHub URL", context do
      with_mock HTTPoison, [post!: fn(_url, _body, _headers) -> "{}" end] do
        Github.process_actions(context.actions)

        # TODO: Mock provides incredibly unhelpful error messages.
        # What's wrong with this?!
        # Can I split this up to pattern-match the args?
        # Then I could have several tests :)
        #
        # assert called HTTPoison.post(
        #   "https://api.github.com/repo/REPO/issues/123/comments",
        #   Poison.Encoder.encode(%{ body: "Hello, world!" }, []),
        #   %{
        #     "Authorization" => "token #{Application.get_env(:samuel, :github_access_key)}"
        #   }
        # )
      end
    end

  end


end
