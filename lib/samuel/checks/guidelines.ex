defmodule Samuel.Checks.Guidelines do
  @moduledoc """
  Posts the guidelines to each Pull Request.

  The guidelines are taken from Reevoo's Guidelines repository.
  """

  @behaviour Samuel.Check

  alias Samuel.Action
  alias Samuel.Github

  def check(event) do
    # Always add the action.
    action(event)
  end

  def action(event) do
    %Action{
      action: :post_comment,
      repo: event["pull_request"]["repository"]["full_name"],
      pull_id: event["pull_request"]["number"],
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
