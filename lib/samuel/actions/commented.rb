defmodule Samuel.Actions.Commented do
  @moduledoc """
  Ensures a Pull Request has been commented on by at least one person.
  """

  import Samuel.Actions

  def check(message) do
    num_comments = message["pull_request"]["comments"]
    case num_comments do
      0 ->
        :fail
      _ ->
        :pass
    end
  end

  def comment(_) do
    """
    I don't see any comments on your Pull Request.

    Are you too good for code reviews now?
    No. No you aren't.

    Maybe you forgot to say who reviewed it. That's fine, but let me know.
    """
  end

end
