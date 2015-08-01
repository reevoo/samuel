defmodule Samuel.HookTest do
  use ShouldI

  alias Samuel.Hook

  with "ping action" do
    should "return :ok" do
      message = %{ "action" => "ping" }
      assert Hook.register( message ) == :ok
    end
  end

  with "opened action" do
    should "return :ok" do
      message = %{ "action" => "opened" }
      assert Hook.register( message ) == :ok
    end
  end

  with "an unknown action" do
    should "return :unknown_action" do
      message = %{ "action" => "wibble wobble" }
      assert Hook.register( message ) == :unknown_action
    end
  end
end
