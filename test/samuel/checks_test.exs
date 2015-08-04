defmodule Samuel.ChecksTest do
  use ShouldI

  alias Samuel.Checks

  with "ping action" do
    should "return no checks" do
      message = %{ "action" => "ping" }
      assert [] = Checks.checks_for( message )
    end
  end

  with "an unknown action" do
    should "return no checks" do
      message = %{ "action" => "wibble wobble" }
      assert [] = Checks.checks_for( message )
    end
  end

  with "a merge" do
    should "returns checks" do
      message = %{
        "action" => "closed",
        "pull_request" => %{
          "merged" => true
        }
      }

      checks = Checks.checks_for( message )
      assert is_list( checks )
      assert length( checks ) > 0
    end
  end

  with "a non-merged close event" do
    should "return no checks" do
      message = %{
        "action" => "closed",
        "pull_request" => %{
          "merged" => false
        }
      }

      assert [] = Checks.checks_for( message )
    end
  end
end
