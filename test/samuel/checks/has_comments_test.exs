defmodule Samuel.Checks.HasCommentsTest do
  use ShouldI
  doctest Samuel.Checks.HasComments

  alias Samuel.Checks.HasComments

  with "a pull request without comments" do
    setup context do
      Dict.put context, :pr, %{
        "action" => "closed",
        "pull_request" => %{
          "comments" => 0,
          "merged" => true,
          "number" => 6,
          "repository" => %{
            "full_name" => "reevoo/samuel"
          }
        }
      }
    end

    should("return a post comment action", context) do
      assert %{
        action: :post_comment
      } = HasComments.check(context[:pr])
    end

    should("get the repo and pull request ID", context) do
      assert %{
        repo: "reevoo/samuel",
        pull_id: 6
      } = HasComments.check(context[:pr])
    end
  end


  with "a pull request with comments" do
    setup context do
      Dict.put context, :pr, %{
        "action" => "closed",
        "pull_request" => %{
          "comments" => 1,
          "merged" => true
        }
      }
    end

    should("return nil", context) do
      assert nil == HasComments.check(context[:pr])
    end
  end
end
