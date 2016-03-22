defmodule Samuel.Checks.OldTest do
  use ShouldI
  alias Samuel.Checks.Old

  having "a new pull request" do
    setup data do
      now = Timex.DateTime.today
      {:ok, now_string} = now |> Timex.format("{ISO:Extended:Z}")

      %{
        event: %{
          "action" => "daily",
        },
        open_prs: %{
          "items" => [
            %{
              "created_at" => now_string
            }
          ]
        },
      }
    end

    should "not comment", data do
      action = Old.check(data)
      assert action == []
    end
  end

  having "a new-enough pull request" do
    setup data do
      now = Timex.DateTime.today
      {:ok, new_time} = now
      |> Timex.shift(days: 1)
      |> Timex.format("{ISO:Extended:Z}")

      %{
        event: %{
          "action" => "daily",
        },
        open_prs: %{
          "items" => [
            %{
              "created_at" => new_time
            }
          ]
        }
      }
    end

    should "not comment", data do
      action = Old.check(data)
      assert action == []
    end
  end

  having "a old pull request (on the comment interval)" do
    setup data do
      now = Timex.DateTime.today
      {:ok, new_time} = now
      |> Timex.shift(days: 7)
      |> Timex.format("{ISO:Extended:Z}")

      %{
        event: %{
          "action" => "daily",
        },
        open_prs: %{
          "items" => [
            %{
              "created_at" => new_time
            }
          ]
        },
        old_pr_message: "OLD-PR-MESSAGE"
      }
    end

    should "comment", data do
      action = Old.check(data)
      assert action != []
    end
  end

  having "a old pull request (after the comment interval)" do
    setup data do
      now = Timex.DateTime.today
      {:ok, new_time} = now
      |> Timex.shift(days: 8)
      |> Timex.format("{ISO:Extended:Z}")

      %{
        event: %{
          "action" => "daily",
        },
        open_prs: %{
          "items" => [
            %{
              "created_at" => new_time
            }
          ]
        }
      }
    end

    should "not comment", data do
      action = Old.check(data)
      assert action == []
    end
  end

  having "a really old pull request (on the comment interval)" do
    setup data do
      now = Timex.DateTime.today
      {:ok, new_time} = now
      |> Timex.shift(days: 14)
      |> Timex.format("{ISO:Extended:Z}")

      %{
        event: %{
          "action" => "daily",
        },
        open_prs: %{
          "items" => [
            %{
              "created_at" => new_time
            }
          ]
        },
        old_pr_message: "OLD-PR-MESSAGE"
      }
    end

    should "comment", data do
      action = Old.check(data)
      assert action != []
    end
  end
end
