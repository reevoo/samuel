defmodule Samuel.ChecksTest do
  use ShouldI
  doctest Samuel.Checks

  alias Samuel.Checks

  having "ping action" do
    should "return no checks" do
      event = %{ "action" => "ping" }
      assert [] = Checks.suitable_checks( event )
    end
  end

  having "an unknown action" do
    should "return no checks" do
      event = %{ "action" => "wibble wobble" }
      assert [] = Checks.suitable_checks( event )
    end
  end

  having "a merge" do
    should "returns checks" do
      event = %{
        "action" => "closed",
        "pull_request" => %{
          "merged" => true
        }
      }

      checks = Checks.suitable_checks( event )
      assert is_list( checks )
      assert length( checks ) > 0
    end
  end

  having "a non-merged close event" do
    should "return no checks" do
      event = %{
        "action" => "closed",
        "pull_request" => %{
          "merged" => false
        }
      }

      assert [] = Checks.suitable_checks( event )
    end
  end
end
