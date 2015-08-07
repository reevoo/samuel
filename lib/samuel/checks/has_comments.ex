defmodule Samuel.Checks.HasComments do
  @moduledoc """
  Ensures a Pull Request has been commented on by at least one person.
  """

  alias Samuel.Github

  def check(message, http_client \\ HTTPoison) do
    case other_user_comments(message) do
      0 ->
        action(message)
      _ ->
        nil
    end
  end

  @doc """
  Returns the number of comments made by someone who is not the Pull Request
  author or Samuel.
  """
  defp other_user_comments(message, http_client \\ HTTPoison) do
    users_that_dont_count = users_that_dont_count(message)

    Github.get_comments(message["pull_request"]["comments_url"], http_client)
    |> Enum.map(fn(c) -> c["user"]["login"] end)
    |> Enum.filter(fn(u) ->
      Enum.all?(users_that_dont_count, fn(n) -> n != u end)
    end)
    |> Enum.count
  end

  @doc "Users whose comments should not be counted."
  defp users_that_dont_count(message) do
    [
      "reevoo-samuel",
      message["pull_request"]["user"]["login"] # Author
    ]
  end

  defp action(message) do
    %{
      action: :post_comment,
      repo: message["pull_request"]["repository"]["full_name"],
      pull_id: message["pull_request"]["number"],
      message: """
      I don't see any comments on your Pull Request.

      Are you too good for code reviews now?
      No. No you aren't.

      Maybe you forgot to say who reviewed it. That's fine, but let me know.
      """
    }
  end

end
