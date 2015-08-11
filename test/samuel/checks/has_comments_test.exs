defmodule Samuel.Checks.HasCommentsTest do
  use ShouldI

  alias Samuel.Checks.HasComments

  with "a pull request without comments" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "number" => 6,
            "repository" => %{
              "full_name" => "reevoo/samuel"
            }
          },
        },
        comments: [],
      }
    end

    should "return a post comment action", data do
      action = HasComments.check(data)

      assert action.action == :post_comment
    end

    should "get the repo and pull request ID", data do
      action = HasComments.check(data)

      assert action.repo == "reevoo/samuel"
      assert action.pull_id == 6
    end
  end

  with "a pull request with comments from Samuel and the author" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "number" => 6,
            "repository" => %{
              "full_name" => "reevoo/samuel"
            },
            "user" => %{
              "login" => "AUTHOR"
            }
          },
        },
        comments: [
          %{ "user" => %{ "login" => "reevoo-samuel" } },
          %{ "user" => %{ "login" => "AUTHOR" } },
        ],
      }
    end

    should "return a post comment action", data do
      action = HasComments.check(data)

      assert action.action == :post_comment
    end
  end

  with "a pull request with comments from others" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "number" => 6,
            "repository" => %{
              "full_name" => "reevoo/samuel"
            },
            "user" => %{
              "login" => "AUTHOR"
            }
          },
        },
        comments: [
          %{ "user" => %{ "login" => "SOMEBODY-ELSE" } },
        ],
      }
    end

    should "return nil", event do
      assert nil == HasComments.check(event)
    end
  end

end
