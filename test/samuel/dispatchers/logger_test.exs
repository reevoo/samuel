defmodule Samuel.Dispatchers.LoggerTest do
  use ShouldI
  import ExUnit.CaptureIO

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
    should "log to IO", context do
      process = fn ->
        Logger.process_actions(context.actions)
      end

      # TODO: Sensibilise the message. (and the word sensibilise.)
      assert capture_io(process) == inspect(hd(context.actions)) <> "\n"
    end

  end


end
