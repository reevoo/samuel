defmodule Samuel.Dispatchers.LoggerTest do
  use ShouldI
  # import ExUnit.CaptureIO

  with "an action" do
    setup context do
      Dict.put context, :actions, [%{
        action: :post_comment,
        repo: "REPO",
        pull_id: 123,
        message: "Hello, world!"
      }]
    end

    # TODO: Work out how we want to test this, and if we want it at all.
    # should "log to IO", context do
    #   process = fn ->
    #     Logger.process_actions(context.actions)
    #   end

    #   # TODO: Sensibilise the message. (and the word sensibilise.)
    #   assert capture_io(process) == inspect(hd(context.actions)) <> "\n"
    # end

  end


end
