defmodule Mix.Tasks.Default do
  @moduledoc """
  Default Mix task.
  """

  use Mix.Task

  def run(_) do
    Mix.Task.run "test"
    Mix.Task.run "dogma"
  end

end
