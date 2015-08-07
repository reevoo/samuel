defmodule Samuel.Checks.HasComments do
  @moduledoc """
  A check ensures a Pull Request has been commented on by at least one person.
  """

  alias Samuel.Github

  @behaviour Samuel.Check


  @doc """
  Takes an event and returns the action that needs to be taken, which could be
  nothing (`nil`).

      iex> event = %{ "pull_request" => %{ "comments" => 1 } }
      iex> Samuel.Checks.HasComments.check(event)
      nil
  """
  def check(event, http_client \\ HTTPoison) do
    case other_user_comments(event) do
      0 ->
        action(event)
      _ ->
        nil
    end
  end


  @doc """
  Takes an event, and returns the action to be performed in the event that this
  check should be failed for the event.
  """
  def action(event) do
    %{
      action: :post_comment,
      repo: event["pull_request"]["repository"]["full_name"],
      pull_id: event["pull_request"]["number"],
      message: """
      I don't see any comments on your Pull Request.

      Are you too good for code reviews now?
      No. No you aren't.

      Maybe you forgot to say who reviewed it. That's fine, but let me know.
      """
    }
  end

  def requirements do
    ~w(comments)a
  end


  # Returns the number of comments made by someone who is not the Pull Request
  # author or Samuel.
  defp other_user_comments(event, http_client \\ HTTPoison) do
    users_that_dont_count = users_that_dont_count(event)

    Github.get_comments(event["pull_request"]["comments_url"], http_client)
    |> Enum.map(fn(c) -> c["user"]["login"] end)
    |> Enum.filter(fn(u) ->
      Enum.all?(users_that_dont_count, fn(n) -> n != u end)
    end)
    |> Enum.count
  end

  defp users_that_dont_count(event) do
    [
      "reevoo-samuel",
      event["pull_request"]["user"]["login"] # Author
    ]
  end
end
