defmodule Samuel.Dispatchers.Github do
  @moduledoc """
  Github interactions.
  """

  def process_actions(actions, http \\ HTTPoison) do
    Enum.map(actions, &process_action(&1, http))
  end


  defp process_action(%{action: :post_comment} = action, http) do
    repo = action.repo
    pull = action.pull_id
    json = Poison.encode!(%{ body: action.message })

    "https://api.github.com/repos/#{repo}/issues/#{pull}/comments"
    |> http.post!(auth_headers, json)
  end

  defp access_token do
    Application.get_env(:samuel, :github_access_key)
  end

  defp auth_headers do
    %{ "Authorization" => "token #{access_token}" }
  end
end
