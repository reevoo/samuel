defmodule Samuel.HookTest do
  use ShouldI

  alias Samuel.Hook

  with "ping action" do
    should "return :ok" do
      message = %{ "action" => "ping" }
      assert {:ok, _} = Hook.register( message )
    end
  end

  with "opened action" do
    should "return :ok" do
      message = %{ "action" => "opened" }
      assert {:ok, _} = Hook.register( message )
    end
  end

  with "an unknown action" do
    should "return :no_action" do
      message = %{ "action" => "wibble wobble" }
      assert {:no_action, _} = Hook.register( message )
    end
  end

  with "a merge" do
    should "return :ok" do
      message = %{
        "action" => "closed",
        "pull_request" => %{
          "merged" => true
        }
      }
      assert {:ok, _} = Hook.register( message )
    end
  end

  with "a non-merged close event" do
    should "return :no_action" do
      message = %{
        "action" => "closed",
        "pull_request" => %{
          "merged" => false
        }
      }
      assert {:no_action, _} = Hook.register( message )
    end
  end
end
