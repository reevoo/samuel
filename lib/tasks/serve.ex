defmodule Mix.Tasks.Serve do
  use Mix.Task

  def run([port_str]) do
    {port, _} = Integer.parse(port_str)
    Samuel.API.Server.start(port)
  end
end
