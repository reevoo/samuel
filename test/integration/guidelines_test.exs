defmodule Samuel.Integration.GuidelinesTest do
  use ShouldI, async: false # :'(
  import Mock

  alias Samuel.TestHelpers.API

  mock_github = quote do
    [
      get: fn(_url) -> "<html></html>" end,
    ]
  end

  with "a pull request is opened" do

    should "post the guidelines to the pull request" do
      with_mock HTTPoison, unquote(mock_github) do



        HTTPoison.get("http://example.com")
        # Tests that make the expected call
        assert called HTTPoison.get("http://example.com")
      end
    end

  end
end
