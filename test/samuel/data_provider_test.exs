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

  having "resolve_requirements/3" do
    having "no checks" do
      should "return the event only" do
        data = DataProvider.resolve_requirements([], %{}, HTTPClient)
        assert data.event == %{}
      end
    end

    having "commit comments" do
      should "get comments from HTTP" do
        event = %{
          "pull_request" => %{
            "review_comments_url" => "COMMENTS-URL"
          }
        }
        checks = [
          %{
            requirements: [:commit_comments]
          }
        ]
        data = DataProvider.resolve_requirements(checks, event, HTTPClient)
        assert data.commit_comments == "DATA-FOR-COMMENTS-URL"
      end
    end

    having "PR comments" do
      should "get comments from HTTP" do
        event = %{
          "pull_request" => %{
            "comments_url" => "PR-URL"
          }
        }
        checks = [
          %{
            requirements: [:pr_comments]
          }
        ]
        data = DataProvider.resolve_requirements(checks, event, HTTPClient)
        assert data.pr_comments == "DATA-FOR-PR-URL"
      end
    end
  end


  having "determine_requirements/1" do
    should "query the given checks for requirements, havingout dupes" do
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


  having "fetch_requirements/3" do

    # Mock HTTP Client
    defmodule JSONClient do
      def get!(url, _) do
        %{
          body: ~s({ "url": "#{url}" }),
          headers: [{ "Content-Type", "application/json; charset=utf8" }]
        }
      end
    end

    having "commit comments" do
      should "look up the commit comments URL from the event and fetch data" do
        requirements = [:commit_comments]
        event = %{
          "pull_request" => %{
            "review_comments_url" => "COMMIT-COMMENTS-URL"
          }
        }
        data = DataProvider.fetch_requirements(requirements, event, JSONClient)
        assert data.commit_comments == %{"url" => "COMMIT-COMMENTS-URL"}
      end
    end

    having "PR comments" do
      should "look up the PR comments URL from the event and fetch data" do
        requirements = [:pr_comments]
        event = %{
          "pull_request" => %{
            "comments_url" => "PR-COMMENTS-URL"
          }
        }
        data = DataProvider.fetch_requirements(requirements, event, JSONClient)
        assert data.pr_comments == %{"url" => "PR-COMMENTS-URL"}
      end
    end

    having "guidelines" do
      should "look up the comments URL from the event and fetch data" do
        requirements = [:guidelines]
        event = nil
        data = DataProvider.fetch_requirements(
          requirements,
          event,
          MarkdownClient
        )
        assert data.guidelines == Application.get_env(
          :samuel,
          :guidelines_message
        )
      end
    end
  end
end
