defmodule Samuel.Checks.HasComments do
  @moduledoc """
  A check ensures a Pull Request has been commented on by at least one person.
  """

  @doc """
  Takes an event and returns a symbol that indicates whether it passes or fails
  the check. i.e. whether it has more than one comment.

      iex> Samuel.Checks.HasComments.check(
      ...>   %{ "pull_request" => %{ "comments" => 0 } }
      ...> )
      :fail

      iex> Samuel.Checks.HasComments.check(
      ...>   %{ "pull_request" => %{ "comments" => 1 } }
      ...> )
      :pass
  """
  def check(event) do
    num_comments = event["pull_request"]["comments"]
    case num_comments do
      0 ->
        :fail
      _ ->
        :pass
    end
  end


  @doc """
  Returns the action to be performed in the event that this check should be
  failed.

  The return value is a tuple with the action type in the first position, and
  the args in the second.
  """
  def action do
    {
      :comment,
      """
      I don't see any comments on your Pull Request.

      Are you too good for code reviews now?
      No. No you aren't.

      Maybe you forgot to say who reviewed it. That's fine, but let me know.
      """
    }
  end

end
