defmodule Samuel.Action do
  @moduledoc """
  Abstract definition of what to do.
  """

  defstruct action: nil,
    repo: nil,
    pull_id: nil,
    message: nil

end
