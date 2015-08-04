defmodule Samuel.Actions do
  @moduledoc """
  Base actions module.
  """

  def check_and_act(message) do
    case check(message) do
      :pass ->
        # Do nothing!
      :fail ->
        Github.post_comment(comment(message))
    end
  end

end
