defmodule Samuel.API.Server do
  @moduledoc """
  This module exposes the `.start/0` function, which is a convienient way of
  starting the application.
  """

  @doc """
  Starts the application, including the API.

  The port used is taken from the `port` environment variable.

  A shell script that starts the server in production mode can be found in
  `bin/prod_run.sh`
  """
  def start(port \\ 4000) do
    {:ok, _} = Plug.Adapters.Cowboy.http(Samuel.API, [], port: port)

    IO.puts """

    I'll just walk the earth... You know, walk the earth, meet people...
    Get into adventures. Like Caine from 'Kung Fu.'

    Running on port #{port}
    """
    no_halt
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) && IEx.started?
  end

  defp no_halt do
    unless iex_running? do
      :timer.sleep :infinity
    end
  end
end
