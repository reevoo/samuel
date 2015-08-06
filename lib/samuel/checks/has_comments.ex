defmodule Samuel.Checks.HasComments do
  @moduledoc """
  Ensures a Pull Request has been commented on by at least one person.
  """

  def check(message) do
    num_comments = message["pull_request"]["comments"]
    case num_comments do
      0 ->
        action(message)
      _ ->
        nil
    end
  end

  def action(message) do
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
