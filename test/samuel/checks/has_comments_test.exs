defmodule Samuel.Checks.HasCommentsTest do
  use ShouldI

  alias Samuel.Checks.HasComments

  having "a pull request without comments" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "comments_url" => "COMMENTS-URL"
          },
        },
        commit_comments: [],
        pr_comments: [],
      }
    end

    should "return a post comment action", data do
      action = HasComments.check(data)

      assert action.action == :post_comment
    end

    should "get the comments URL", data do
      action = HasComments.check(data)

      assert action.comments_url == "COMMENTS-URL"
    end
  end

  having "a pull request with PR comments from Samuel and the author" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "user" => %{
              "login" => "AUTHOR"
            },
            "comments_url" => "COMMENTS-URL"
          },
        },
        pr_comments: [
          %{ "user" => %{ "login" => "reevoo-samuel" } },
          %{ "user" => %{ "login" => "AUTHOR" } },
        ],
        commit_comments: [],
      }
    end

    should "return a post comment action", data do
      action = HasComments.check(data)

      assert action.action == :post_comment
    end
  end

  having "a pull request with PR comments from others" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "user" => %{
              "login" => "AUTHOR"
            },
            "comments_url" => "COMMENTS-URL"
          },
        },
        pr_comments: [
          %{ "user" => %{ "login" => "SOMEBODY-ELSE" } },
        ],
        commit_comments: [],
      }
    end

    should "return nil", event do
      assert nil == HasComments.check(event)
    end
  end

  having "a pull request with commit comments from Samuel and the author" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "user" => %{
              "login" => "AUTHOR"
            },
            "comments_url" => "COMMENTS-URL"
          },
        },
        commit_comments: [
          %{ "user" => %{ "login" => "reevoo-samuel" } },
          %{ "user" => %{ "login" => "AUTHOR" } },
        ],
        pr_comments: [],
      }
    end

    should "return a post comment action", data do
      action = HasComments.check(data)

      assert action.action == :post_comment
    end
  end

  having "a pull request with commit comments from others" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "user" => %{
              "login" => "AUTHOR"
            },
            "comments_url" => "COMMENTS-URL"
          },
        },
        commit_comments: [
          %{ "user" => %{ "login" => "SOMEBODY-ELSE" } },
        ],
        pr_comments: [],
      }
    end

    should "return nil", event do
      assert nil == HasComments.check(event)
    end
  end

end
