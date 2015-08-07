# defmodule Samuel.Github do
#   @moduledoc """
#   Github client.
#   Not to be confused with the action dispatcher!
#   """
#
#   @doc "Gets the content of a file in GitHub."
#   def get_raw_file(repo, path, http_client \\ HTTPoison) do
#     access_token = Application.get_env(:samuel, :github_access_key)
#
#     response = http_client.get!(
#       "https://api.github.com/repos/#{repo}/contents/#{path}",
#       %{
#         "Authorization" => "token #{access_token}",
#         "Accept" => "application/vnd.github.v3.raw"
#       }
#     )
#
#     response.body
#   end
#
#   @doc "Gets all comments for a Pull Request."
#   def get_comments(repo, pull_id) do
#     get_comments("https://api.github.com/repos/#{repo}/issues/#{pull_id}/comments")
#   end
#
#   def get_comments(url, http_client \\ HTTPoison) do
#     access_token = Application.get_env(:samuel, :github_access_key)
#
#     response = http_client.get!(url,
#       %{
#         "Authorization" => "token #{access_token}",
#       }
#     )
#
#     Poison.Parser.parse!(response.body)
#   end
#
#   @doc "Posts a comment to a Pull Request."
#   def post_comment(repo, pull_id, message, http_client \\ HTTPoison) do
#     access_token = Application.get_env(:samuel, :github_access_key)
#
#     http_client.post!(
#       "https://api.github.com/repos/#{repo}/issues/#{pull_id}/comments",
#       Poison.Encoder.encode(%{ body: message }, []),
#       %{
#         "Authorization" => "token #{access_token}"
#       }
#     )
#   end
#
# end
