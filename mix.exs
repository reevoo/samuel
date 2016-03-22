defmodule Samuel.Mixfile do
  use Mix.Project

  def project do
    [
      app: :samuel,
      version: "0.0.1",
      elixir: "~> 1.1",
      source_url: "https://github.com/reevoo/samuel",
      homepage_url: "https://github.com/reevoo/samuel",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps,
      default_task: "default",
      preferred_cli_env: [default: :test]
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [:logger, :httpoison, :tzdata],
      mod: {Samuel, []}
    ]
  end

  defp deps do
    [
      # Web server
      {:cowboy, "~> 1.0"},
      # Web app router and server connector
      {:plug, "~> 0.13"},
      # JSON encoder/decoder
      {:poison, "~> 1.5"},
      # HTTP Client
      {:httpoison, "~> 0.7"},
      # Timey wimey stuff
      {:timex, "~> 2.1"},

      # BDD test macros
      {:shouldi, "~> 0.3", only: :test},
      # Mocks. Duh.
      {:mock, "~> 0.1", only: :test},
      # Automatic test runner
      {:mix_test_watch, "~> 0.0", only: :dev},
      # Style linter
      {:dogma, "~> 0.0", only: ~w(dev test)a},

      # Markdown processor
      {:earmark, "~> 0.1", only: :dev},
      # Documentation generator
      {:ex_doc, "~> 0.8", only: :dev},
      # Documentation inspector
      {:inch_ex, "~> 0.0", only: ~w(dev docs)a},
    ]
  end
end
