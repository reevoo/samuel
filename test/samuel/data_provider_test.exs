defmodule Samuel.DataProviderTest do
  use ShouldI
  alias Samuel.DataProvider

  doctest Samuel.DataProvider

  defmodule HTTPClient do
    def get!(url, _) do
      %{
        body: ~s(DATA-FOR-#{url}),
        headers: [{ "Content-Type", "text/plain" }]
      }
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
      should "get comments from HTTP" do
        event = %{
          "pull_request" => %{
            "comments_url" => "COMMENTS-URL"
          }
        }
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
    with "comments" do

      defmodule JSONClient do
        def get!(url, _) do
          %{
            body: ~s({ "url": "#{url}" }),
            headers: [{ "Content-Type", "application/json; charset=utf8" }]
          }
        end
      end

      should "look up the comments URL from the event and fetch data" do
        requirements = [:comments]
        event = %{
          "pull_request" => %{
            "comments_url" => "COMMENTS-URL"
          }
        }
        data = DataProvider.fetch_requirements(requirements, event, JSONClient)
        assert data.comments == %{"url" => "COMMENTS-URL"}
      end
    end
    
    with "guidelines" do

      defmodule MarkdownClient do
        def get!(url, _) do
          %{
            body: ~s(### This is the content for #{url}),
            headers: [{ "Content-Type", "text/markdown" }]
          }
        end
      end

      should "look up the comments URL from the event and fetch data" do
        requirements = [:guidelines]
        event = nil
        data = DataProvider.fetch_requirements(
          requirements,
          event,
          MarkdownClient
        )
        guidelines = "### This is the content for https://api.github.com/repos/"
                  <> "reevoo/guidelines/contents/pull_requests.md"
        assert data.guidelines == guidelines
      end
    end
  end
end
