defmodule Samuel.Checks.Guidelines do
  @moduledoc """
  Posts the guidelines to each Pull Request.

  The guidelines are taken from Reevoo's Guidelines repository.
  """

  alias Samuel.Action
  alias Samuel.Github

  def check(message) do
    # Always add the action.
    %Action{
      action: :post_comment,
      repo: message["pull_request"]["repository"]["full_name"],
      pull_id: message["pull_request"]["number"],
      message: """
      Guidelines, mofo. Read them.

      #{guidelines}
      """
    }
  end

  def guidelines do
    Github.get_raw_file("reevoo/guidelines", "pull_requests.md")
  end

end
