defmodule Samuel.Dispatcher do
  @moduledoc """
  The Dispatcher behaviour, used to assert the interface used by our dispatcher
  modules.
  """

  use Behaviour
  alias Samuel.Action

  @type action :: Action

  @doc """
  A function that performs the given action.
  """
  defcallback process_actions(action) :: none

end
