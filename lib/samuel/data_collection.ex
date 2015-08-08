defmodule Samuel.DataCollection do
  @moduledoc """
  Determines the additional data required by the Checks for an event, and
  collects the data from the GitHub API via a HTTP client.
  """


  @doc """
  Given a list of checks, a GitHub webhook event, and optionally a HTTP client
  module, this function determines what the dependencies of the checks are, and
  then gets them from the GitHub API via HTTP requests with the given module.

  It actually delegates to the `determine_requirements/1` and
  `fetch_requirement/3` functions.
  """
  def resolve_requirements(checks, event, http \\ HTTPoison) do
    checks
    |> determine_requirements
    |> fetch_requirements(event, http)
  end


  @doc """
  Queries each of the given checks for their dependencies, and returns a list
  of atoms representing the dependencies, without duplication.
  """
  def determine_requirements(checks) do
    checks
    |> Enum.flat_map(fn(check) -> check.requirements end)
    |> Enum.uniq
  end


  @doc """
  Fetches the dependancies given using the optionally given HTTP client module,
  and returns them in a map.

  The event is also added to the map.

      iex> Samuel.DataCollection.fetch_requirements([], "An event!")
      %{ event: "An event!" }
  """
  def fetch_requirements(requirements, event, http \\ HTTPoison) do
    fun = fn (req, acc) ->
      data = fetch(req, event, http)
      Dict.put(acc, req, data)
    end
    requirements |> Enum.reduce(%{ event: event }, fun)
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
