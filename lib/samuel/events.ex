defmodule Samuel.Events do
  @moduledoc """
  Utilities for responding to events.
  """

  alias Samuel.Checks
  alias Samuel.DataProvider
  alias Samuel.Dispatchers

  def respond(event) do
    checks = event |> Checks.suitable_checks
    data   = checks |> DataProvider.resolve_requirements(event)

    checks
    |> Checks.perform_checks(data)
    |> Dispatchers.perform_actions!
  end
end
