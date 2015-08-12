defmodule Samuel.Dispatchers.Logger do
  @moduledoc """
  Prints the actions to be taken to STDOUT.
  """

  @behaviour Samuel.Dispatcher

  def process_actions(_actions) do
    # Enum.each(actions, &log/1)
  end

  # This is really annoying so I'm turning it off.
  # defp log(action) do
  #   IO.inspect action
  # end

end
