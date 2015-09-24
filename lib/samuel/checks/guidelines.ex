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
      message: data.guidelines
    }
  end

  def requirements do
    ~w(guidelines)a
  end

end
