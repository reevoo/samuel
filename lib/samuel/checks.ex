defmodule Samuel.Checks do
  @moduledoc """
  Pattern-matches against the message to return a
  list of checks to run against the message.
  """

  @doc "Returns a set of checks depending on the event received."
  def checks_for(message) do
    checks_for(message["action"], message)
  end

  # A Pull Request 'merge' event occurs when the action is closed
  # and "merged" is true on the Pull Request.
  # https://developer.github.com/v3/activity/events/types/#pullrequestevent
  defp checks_for("closed", %{"pull_request" => %{"merged" => true}}) do
    [
      Samuel.Checks.HasComments
    ]
  end

  # If we don't recognise the event, we don't return any actions.
  # (NB. 'ping' goes here!)
  defp checks_for(_, _) do
    []
  end
end
