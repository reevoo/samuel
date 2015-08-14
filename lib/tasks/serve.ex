defmodule Mix.Tasks.Serve do
  use Mix.Task

  def run(port) do
    Samuel.API.Server.start(Integer.parse port)
  end
end
