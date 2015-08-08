defmodule Samuel.Dispatchers do
  @moduledoc """
  Dispatchers listen to the reports from Checks and act on them.
  """

  @dispatchers [
    Samuel.Dispatchers.Logger,
    Samuel.Dispatchers.Github
  ]

  def perform_actions!(actions) do
    actions = actions |> strip_nils
    Enum.each(@dispatchers, fn d -> d.process_actions(actions) end)
  end

  defp strip_nils(list) do
    list
    |> Enum.filter(fn(x) -> x !== nil end)
  end
end
