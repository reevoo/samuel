defmodule Samuel.Hook do
  @moduledoc """
  Entry point for github hooks from the API.

  Responds to a limited subset of github hook actions.
  """


  def register(message) do
    register(message["action"], message)
  end

  defp register("ping", _) do
    {:ok, "Pong!"}
  end
  defp register("opened", _) do
    {:ok, "No action taken for open."}
  end
  # A Pull Request 'merge' event occurs when the action is closed
  # and "merged" is true on the Pull Request.
  # https://developer.github.com/v3/activity/events/types/#pullrequestevent
  defp register("closed", %{"pull_request" => %{"merged" => true}}) do
    {:ok, "No action taken for merge."}
  end
  defp register(action, _) do
    {:no_action, "No action for #{action}"}
  end
end
