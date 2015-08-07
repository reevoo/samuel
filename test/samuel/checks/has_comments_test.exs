# defmodule Samuel.Checks.HasCommentsTest do
#   use ShouldI
#
#   defmodule DummyHTTPClient do
#
#     def post!(url, body, headers) do
#       IO.inspect %{
#         url: url,
#         body: body,
#         headers: headers,
#       }
#     end
#
#     def get!(url, headers) do
#       IO.inspect %{
#         url: url,
#         headers: headers,
#       }
#     end
#
#   end
#
#   alias Samuel.Checks.HasComments
#
#   with "a pull request without comments" do
#     setup event do
#       %{
#         "action" => "closed",
#         "pull_request" => %{
#           "comments" => 0,
#           "merged" => true,
#           "number" => 6,
#           "repository" => %{
#             "full_name" => "reevoo/samuel"
#           },
#           "comments_url" => "GITHUB-COMMENTS-URL",
#         }
#       }
#     end
#
#     should "return a post comment action", event do
#       action = HasComments.check(event)
#
#       assert action.action == :post_comment
#     end
#
#     should "get the repo and pull request ID", event do
#       action = HasComments.check(event)
#
#       assert action.repo == "reevoo/samuel"
#       assert action.pull_id == 6
#     end
#   end
#
#   with "a pull request with comments" do
#     setup event do
#       %{
#         "action" => "closed",
#         "pull_request" => %{
#           "comments" => 1,
#           "merged" => true,
#           "comments_url" => "GITHUB-COMMENTS-URL",
#         }
#       }
#     end
#
#     should "return nil", event do
#       assert nil == HasComments.check(event)
#     end
#   end
#
# end
