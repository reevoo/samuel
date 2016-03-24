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
  """
  def perform_checks(checks, %{event: _} = data) do
    checks
    |> Enum.flat_map(fn(module) -> check_and_ensure_list(module, data) end)
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

  defp suitable_checks("daily", _) do
    [
      Samuel.Checks.Old
    ]
  end

  defp suitable_checks(_, _) do
    []
  end

  defp check_and_ensure_list(module, data) do
    actions = module.check(data)
    case actions do
      a when is_list(a) -> a
      a -> [a]
    end
  end
end
