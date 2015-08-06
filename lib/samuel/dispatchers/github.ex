defmodule Samuel.Dispatchers.Github do
  @moduledoc """
  Github interactions.
  """

  def process_actions(actions) do
    Enum.map(actions, fn a -> apply(Samuel.Dispatchers.Github, a[:action], [a]) end)
  end

  def post_comment(action) do
    post_comment(action[:repo], action[:pull_id], action[:message])
  end

  # /repos/:owner/:repo/issues/:number/comments
  defp post_comment(repo, pull_id, message) do
    access_token = Application.get_env(:samuel, :github_access_key)

    HTTPoison.post!(
      "https://api.github.com/repo/#{repo}/issues/#{pull_id}/comments",
      Poison.Encoder.encode(%{ body: message }, []),
      %{
        "Authorization" => "token #{access_token}"
      }
    )
  end

end
