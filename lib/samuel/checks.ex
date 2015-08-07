defmodule Samuel.Checks do
  @moduledoc """
  A module responsible for determining what "checks" need to be performed for
  each event recieved from GitHub via the API.

  Actions
  =======

  ## Opened

  Occures when a pull request is opened. Amazing!

  ## Closed

  Occures when a pull request is closed. If it is closed with a merge, then
  `event["pull_request"]["merged"]` will be `true`.
  """

  @doc """
  Takes an event from GitHub and returns a list of "check" modules that should
  run for this type of event.

  Unrecognised events result in an empty list. (i.e. the "ping" event)

      iex> Samuel.Checks.checks_for(%{"action" => "ping"})
      []
  """
  def checks_for(event) do
    checks_for(event["action"], event)
  end

  defp checks_for("opened", _) do
    [
      Samuel.Checks.Guidelines
    ]
  end

  # When a PR is opened.
  defp checks_for("opened", _) do
    [
      Samuel.Checks.Guidelines
    ]
  end

  # A Pull Request 'merge' event occurs when the action is closed
  # and "merged" is true on the Pull Request.
  # https://developer.github.com/v3/activity/events/types/#pullrequestevent
  defp checks_for("closed", %{"pull_request" => %{"merged" => true}}) do
    [
      Samuel.Checks.HasComments
    ]
  end

  defp checks_for(_, _) do
    []
  end
end
