defmodule Samuel.Check do
  @moduledoc """
  The Check behaviour, used to assert the interface used by our check modules.
  """

  use Behaviour

  @type event  :: Map
  @type action :: Map

  @doc """
  A function that checks event data to see whether or not it passes the check.
  """
  defcallback check(event)  :: none | action


  @doc """
  A function that returns the action that needs to be taken for an event,
  *presuming that the event fails the check*.
  
  It should not test to see if it fails or not.
  """
  defcallback action(event) :: action
end
