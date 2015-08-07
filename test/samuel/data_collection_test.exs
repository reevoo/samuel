defmodule Samuel.DataCollectionTest do
  use ShouldI
  alias Samuel.DataCollection

  defmodule DummyHTTPClient do
    def get!(url, _headers) do
      %{ body: "\"DATA-FOR-#{url}\"" }
    end
  end

  with "no checks" do
    should "return the event only" do
      data = DataCollection.get_requirements([], %{}, DummyHTTPClient)
      assert data.event == %{}
    end
  end

  with "comments" do
    setup event do
      %{
        "pull_request" => %{
          "comments_url" => "COMMENTS-URL"
        }
      }
    end

    should "get comments from HTTP", event do
      checks = [
        %{
          requirements: [:comments]
        }
      ]
      data = DataCollection.get_requirements(checks, event, DummyHTTPClient)
      assert data.comments == "DATA-FOR-COMMENTS-URL"
    end
  end

end
