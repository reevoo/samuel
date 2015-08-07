defmodule Samuel.DataCollection do
  @moduledoc """
  Determines the data required by the Checks
  and collects the data via a HTTP client.
  """

  def collect_for(checks, event, http \\ HTTPoison) do
    data_requirements(checks)
    |> Enum.reduce(%{ event: event }, fn(req, acc) ->
      data = fetch(req, event, http)
      Dict.put(acc, req, data)
    end)
  end

  defp data_requirements(checks) do
    Enum.flat_map(checks, fn(c) -> c.data_required end)
    |> Enum.uniq
  end

  defp fetch(:comments, event, http) do
    get(event["pull_request"]["comments_url"], http)
  end

  defp get(url, http) do
    access_token = Application.get_env(:samuel, :github_access_key)

    response = http.get!(url,
      %{
        "Authorization" => "token #{access_token}",
      }
    )

    Poison.Parser.parse!(response.body)
  end

end
