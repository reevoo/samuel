defmodule Samuel.API.Server do
  @moduledoc """
  This module exposes the `.start/0` function, which is a convienient way of
  starting the application.
  """

  @doc """
  Starts the application, including the API. The port used is taken from the
  `port` environment variable.
  """
  def start do
    {:ok, _} = Plug.Adapters.Cowboy.http(Samuel.API, [], port: port)

    IO.puts """

    I'll just walk the earth... You know, walk the earth, meet people...
    Get into adventures. Like Caine from "Kung Fu."

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

  defp port do
    System.get_env("PORT") || 4000
  end
end
