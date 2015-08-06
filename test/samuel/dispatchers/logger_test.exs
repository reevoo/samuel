defmodule Samuel.Dispatchers.LoggerTest do
  use ShouldI
  import Mock

  alias Samuel.Dispatchers.Logger

  with "an action" do
    setup context do
      Dict.put context, :actions, [%{
        action: :post_comment,
        repo: "REPO",
        pull_id: 123,
        message: "Hello, world!"
      }]
    end

    @tag :pending
    should("log to IO", context) do
      with_mock IO, [inspect: fn(_obj) -> nil end] do
        Logger.process_actions(context[:actions])

        # TODO: Mock provides incredibly unhelpful error messages.
        # What's wrong with this?!
        #
        # assert called IO.inspect(context[:actions])
      end
    end

  end


end
