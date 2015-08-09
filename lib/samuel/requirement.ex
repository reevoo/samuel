defmodule Samuel.Requirement do
  @moduledoc """
  A struct used to represent a requirement a checker has.

  Examples might be the comments from a pull request, or a raw source file from
  the repository the pull request is made to.
  """

  defstruct type: nil,
            args: nil
end
