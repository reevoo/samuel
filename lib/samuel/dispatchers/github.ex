defmodule Samuel.Dispatchers.Github do
  @moduledoc """
  Github interactions.
  """

  alias Samuel.Github

  def process_actions(actions) do
    Enum.map(actions, &process_action/1)
  end

  defp process_action(%{action: :post_comment} = action) do
    Github.post_comment(action.repo, action.pull_id, action.message)
  end

end
