defmodule Samuel.Logger do
  @moduledoc """
  Basic logger.
  """

  def process_actions(actions) do
    Enum.map(actions, fn a -> log(a) end)
  end

  defp log(action) do
    IO.inspect action

    action
  end

end
