defmodule Samuel.Checks.HasComments do
  @moduledoc """
  A check ensures a Pull Request has been commented on by at least one person.
  """

  @behaviour Samuel.Check

  alias Samuel.Action

  def check(data) do
    case other_user_comments(data) do
      0 ->
        action(data.event)
      _ ->
        nil
    end
  end

  def action(event) do
    %Action{
      action: :post_comment,
      comments_url: event["pull_request"]["comments_url"],
      message: """
      I don't see any comments on your Pull Request.

      Are you too good for code reviews now?
      No. No you aren't.

      Maybe you forgot to say who reviewed it. That's fine, but let me know.
      """
    }
  end

  def requirements do
    ~w(commit_comments pr_comments)a
  end

  defp all_comments(data) do
    data.commit_comments ++ data.pr_comments
  end

  # Returns the number of comments made by someone who is not the Pull Request
  # author or Samuel.
  defp other_user_comments(data) do
    ignored_users = users_that_dont_count(data.event)

    data
    |> all_comments
    |> Enum.map(fn(c) -> c["user"]["login"] end)
    |> Enum.filter(fn(u) ->
      Enum.all?(ignored_users, fn(n) -> n != u end)
    end)
    |> Enum.count
  end

  # List of users whose comments do not count towards the comment count.
  defp users_that_dont_count(event) do
    [
      "reevoo-samuel",
      event["pull_request"]["user"]["login"] # Author
    ]
  end
end
