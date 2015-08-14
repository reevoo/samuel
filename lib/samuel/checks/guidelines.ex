defmodule Samuel.Checks.Guidelines do
  @moduledoc """
  Posts the guidelines to each Pull Request when it is opened.
  """

  @behaviour Samuel.Check

  alias Samuel.Action

  def check(data) do
    # Always add the action.
    action(data)
  end

  def action(data) do

    %Action{
      action: :post_comment,
      repo: data.event["repository"]["full_name"],
      pull_id: data.event["pull_request"]["number"],
      message: guidelines
    }
  end

  def requirements do
    []
  end

  defp guidelines do
    Application.get_env(:samuel, :guidelines_message)
  end
end
