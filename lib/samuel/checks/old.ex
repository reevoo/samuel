defmodule Samuel.Checks.Old do
  @moduledoc """
  Posts if a Pull Request gets too old.

  Only run this once a day! Otherwise, it will hammer your PRs
  on day 7.
  """

  @behaviour Samuel.Check

  alias Samuel.Action

  def check(data) do
    data.open_prs["items"]
    |> Enum.map(fn(pr) -> check(pr, data) end)
    |> Enum.reject(fn(action) -> action == nil end)
  end

  defp check(pr, data) do
    days = days_since_creation(pr)

    if days != 0 && rem(days, 7) == 0 do
      action(pr, data)
    else
      nil
    end
  end

  def action(pr, data) do
    %Action{
      action: :post_comment,
      comments_url: pr["comments_url"],
      message: data.old_pr_message
    }
  end

  def requirements do
    ~w(open_prs old_pr_message)a
  end

  defp days_since_creation(pr) do
    {:ok, creation_date} = Timex.parse(pr["created_at"], "{ISO:Extended:Z}")
    now = Timex.DateTime.today

    Timex.diff(creation_date, now, :days)
  end
end
