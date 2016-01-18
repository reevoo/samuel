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
            "number" => 6
          },
          "repository" => %{
            "full_name" => "reevoo/samuel"
          }
        },
        commit_comments: [],
        pr_comments: [],
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

  with "a pull request with PR comments from Samuel and the author" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "number" => 6,
            "user" => %{
              "login" => "AUTHOR"
            }
          },
          "repository" => %{
            "full_name" => "reevoo/samuel"
          }
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

  with "a pull request with PR comments from others" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "number" => 6,
            "user" => %{
              "login" => "AUTHOR"
            }
          },
          "repository" => %{
            "full_name" => "reevoo/samuel"
          }
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

  with "a pull request with commit comments from Samuel and the author" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "number" => 6,
            "user" => %{
              "login" => "AUTHOR"
            }
          },
          "repository" => %{
            "full_name" => "reevoo/samuel"
          }
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

  with "a pull request with commit comments from others" do
    setup data do
      %{
        event: %{
          "action" => "closed",
          "pull_request" => %{
            "merged" => true,
            "number" => 6,
            "user" => %{
              "login" => "AUTHOR"
            }
          },
          "repository" => %{
            "full_name" => "reevoo/samuel"
          }
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
