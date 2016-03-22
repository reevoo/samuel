defmodule Mix.Tasks.DailyChecks do
  @moduledoc """
  Runs daily checks.
  """

  use Mix.Task
  alias Samuel.Events

  def run(_args) do
    Events.respond(tick_event)
  end

  defp tick_event do
    %{
      "action" => "daily"
    }
  end
end
