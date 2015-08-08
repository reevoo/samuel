defmodule Samuel.DataCollection do
  @moduledoc """
  Determines the additional data required by the Checks for an event, and
  collects the data from the GitHub API HTTP client.
  """

  def resolve_requirements(checks, event, http \\ HTTPoison) do
    checks
    |> determine_requirements
    |> fetch_requirements(event, http)
  end

  def determine_requirements(checks) do
    checks
    |> Enum.flat_map(fn(check) -> check.requirements end)
    |> Enum.uniq
  end

  def fetch_requirements(requirements, event, http \\ HTTPoison) do
    requirements
    |> Enum.reduce(%{ event: event }, fn (req, acc) ->
      data = fetch(req, event, http)
      Dict.put(acc, req, data)
    end)

  end


  defp fetch_requirement(req, http, event) do
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
