defmodule Samuel.Hook do
  @moduledoc """
  Entry point for github hooks from the API.

  Responds to a limited subset of github hook actions.
  """


  def register(message) do
    register(message["action"], message)
  end

  defp register("ping", _) do
    :ok
  end
  defp register("opened", _) do
    :ok
  end
  defp register(_, _) do
    :unknown_action
  end
end
