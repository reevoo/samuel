defmodule Samuel.Checks.HasComments do
  @moduledoc """
  A check ensures a Pull Request has been commented on by at least one person.
  """

  @doc """
  Takes an event and returns the action that needs to be taken, which could be
  nothing (`nil`).

      iex> event = %{ "pull_request" => %{ "comments" => 1 } }
      iex> Samuel.Checks.HasComments.check(event)
      nil
  """
  def check(event) do
    num_comments = event["pull_request"]["comments"]
    # TODO: There's more to it than this.
    # We need to count the number of comments
    # NOT made by samuel.
    num_comments = event["pull_request"]["comments"]
    case num_comments do
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

end
