defmodule Samuel.DataProviderTest do
  use ShouldI
  alias Samuel.DataProvider

  doctest Samuel.DataProvider

  defmodule HTTPClient do
    def get!(url, _headers) do
      %{ body: ~s("DATA-FOR-#{url}") }
    end
  end

  with "resolve_requirements/3" do
    with "no checks" do
      should "return the event only" do
        data = DataProvider.resolve_requirements([], %{}, HTTPClient)
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
        data = DataProvider.resolve_requirements(checks, event, HTTPClient)
        assert data.comments == "DATA-FOR-COMMENTS-URL"
      end
    end
  end

  with "determine_requirements/1" do
    should "query the given checks for requirements, without dupes" do
      checks = [
        %{ requirements: ~w(foo)a },
        %{ requirements: ~w(foo bar)a },
        %{ requirements: ~w(baz bun)a },
        %{ requirements: ~w(baz)a },
      ]
      requirements = DataProvider.determine_requirements(checks)
      assert requirements == ~w(foo bar baz bun)a
    end
  end

  with "fetch_requirements/3" do
    should "look up the comments URL from the event and fetch data" do
      requirements = [:comments]
      event = %{
        "pull_request" => %{
          "comments_url" => "COMMENTS-URL"
        }
      }
      data = DataProvider.fetch_requirements(requirements, event, HTTPClient)
      assert data.comments == "DATA-FOR-COMMENTS-URL"
    end
  end
end
