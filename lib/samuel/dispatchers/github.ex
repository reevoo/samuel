defmodule Samuel.Dispatchers.Github do
  @moduledoc """
  Github interactions.
  """

  @behaviour Samuel.Dispatcher

  def process_actions(actions, http \\ HTTPoison) do
    Enum.map(actions, &process_action(&1, http))
  end

  defp process_action(%{action: :post_comment} = action, http) do
    post(
      action.comments_url,
      action.message,
      http
    )
  end

  defp post(url, message, http) do
    json = Poison.encode!(%{ body: message })
    http.post!(url, json, auth_headers)
  end

  defp access_token do
    Application.get_env(:samuel, :github_access_key)
  end

  defp auth_headers do
    [{ "Authorization", "token #{access_token}" }]
  end
end
