defmodule Samuel.Dispatchers do
  @moduledoc """
  Dispatchers listen to the reports from Checks and act on them.
  """

  @dispatchers [
    Samuel.Dispatchers.Logger,
    Samuel.Dispatchers.Github
  ]

  def process_actions(actions) do
    Enum.each(@dispatchers, fn d -> d.process_actions(actions) end)
  end

end
