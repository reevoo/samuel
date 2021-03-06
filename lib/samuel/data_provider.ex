defmodule Samuel.DataProvider do
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

      iex> Samuel.DataProvider.fetch_requirements([], "An event!")
      %{ event: "An event!" }
  """
  def fetch_requirements(requirements, event, http \\ HTTPoison) do
    fun = fn (req, acc) ->
      data = fetch(req, event, http)
      Dict.put(acc, req, data)
    end
    requirements |> Enum.reduce(%{ event: event }, fun)
  end


  defp fetch(:pr_comments, event, http) do
    get(
      event["pull_request"]["comments_url"],
      %{"Content-Type" => "application/json"},
      http
    )
  end

  defp fetch(:commit_comments, event, http) do
    get(
      event["pull_request"]["review_comments_url"],
      %{"Content-Type" => "application/json"},
      http
    )
  end

  defp fetch(:open_prs, _, http) do
    org = Application.get_env(:samuel, :github_org_name)
    open_prs_url = "https://api.github.com/search/issues" <>
      "?q=type:pr+state:open+user:#{org}"

    get(
      open_prs_url,
      %{"Content-Type" => "application/json"},
      http
    )
  end

  defp fetch(:guidelines, _, _) do
    Application.get_env(:samuel, :guidelines_message)
  end

  defp fetch(:old_pr_message, _, _) do
    Application.get_env(:samuel, :old_pr_message)
  end

  defp get(url, headers, http) do
    headers = Map.merge(default_headers, headers)
    response = http.get!(url, headers)

    parse(response.body, response.headers)
  end

  defp parse(body, headers) when is_list(headers) do
    content_type = headers |> Enum.find_value(fn
      {"Content-Type", type} -> type
      _ -> nil
    end)

    parse(body, content_type)
  end

  defp parse(body, << "application/json"::utf8, _::binary >>) do
    Poison.Parser.parse!(body)
  end

  defp parse(body, _) do
    body
  end

  defp default_headers do
    access_token = Application.get_env(:samuel, :github_access_key)
    %{
      "Authorization" => "token #{access_token}"
    }
  end
end
