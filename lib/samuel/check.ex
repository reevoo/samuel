defmodule Samuel.Check do
  @moduledoc """
  The Check behaviour, used to assert the interface used by our check modules.
  """

  use Behaviour

  @type pull_request_data :: Map
  @type action      :: Map
  @type requirement :: Atom

  @doc """
  A function that checks event data to see whether or not it passes the check.
  """
  defcallback check(pull_request_data)  :: none | action


  @doc """
  A function that returns the action that needs to be taken for an event,
  *presuming that the event fails the check*.
  
  It should not test to see if it fails or not.
  """
  defcallback action(pull_request_data) :: action


  @doc """
  A function that returns a list of the requirements of the checker that must
  be resolved and added to the `pull_request_data` before `check/1` has
  sufficient data to run.
  """
  defcallback requirements :: [requirement]
end
