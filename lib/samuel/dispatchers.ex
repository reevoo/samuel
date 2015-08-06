defmodule Samuel.Dispatchers do
  @moduledoc """
  Dispatchers listen to the reports from Checks and act on them.
  """

  def process_actions(actions) do
    dispatchers = [
      Samuel.Dispatchers.Logger,
      Samuel.Dispatchers.Github
    ]

    Enum.map(dispatchers, fn d -> d.process_actions(actions) end)
  end

end
