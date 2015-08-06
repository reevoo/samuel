defmodule Samuel.Checks.Guidelines do
  @moduledoc """
  Posts the guidelines to each Pull Request.

  The guidelines are taken from Reevoo's Guidelines repository.
  """

  def check(message) do
    # Always add the action.
    %{
      action: :post_comment,
      repo: message["pull_request"]["repository"]["full_name"],
      pull_id: message["pull_request"]["number"],
      message: """
        Guidelines, mofo. Read them.

        #{guidelines}
      """
    }
  end

  def guidelines do
    access_token = Application.get_env(:samuel, :github_access_key)

    response = HTTPoison.get!(
      "https://api.github.com/repos/reevoo/guidelines/contents/pull_requests.md",
      %{
        "Authorization" => "token #{access_token}",
        "Accept" => "application/vnd.github.v3.raw"
      }
    )

    response.body
  end

end
