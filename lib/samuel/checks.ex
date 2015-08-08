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
  Takes an event, and performs all suitable checks upon it.

  TODO: We need to query the GitHub API for additional data on the pull
  request. This isn't really the domain of this module, so we should create
  some orchestration module that does this stuff and only uses this one to get
  the suitable checks.
  """
  def perform_checks(event) do
    event
    |> suitable_checks
    |> Enum.map(fn(module) -> module.check(event) end)
  end


  @doc """
  Takes an event from GitHub and returns a list of "check" modules that should
  run for this type of event.

  Unrecognised events result in an empty list. (i.e. the "ping" event)

      iex> Samuel.Checks.suitable_checks(%{"action" => "ping"})
      []
  """
  def suitable_checks(event) do
    suitable_checks(event["action"], event)
  end

  defp suitable_checks("opened", _) do
    [
      Samuel.Checks.Guidelines
    ]
  end

  defp suitable_checks("closed", %{"pull_request" => %{"merged" => true}}) do
    [
      Samuel.Checks.HasComments
    ]
  end

  defp suitable_checks(_, _) do
    []
  end
end
