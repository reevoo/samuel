defmodule Mix.Tasks.Default do
  use Mix.Task

  def run(_) do
    Mix.Task.run "test"
    Mix.Task.run "dogma"
  end

end
