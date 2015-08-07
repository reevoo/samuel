defmodule Samuel.Mixfile do
  use Mix.Project

  def project do
    [
      app: :samuel,
      version: "0.0.1",
      elixir: "~> 1.0",
      source_url: "https://github.com/reevoo/samuel",
      homepage_url: "https://github.com/reevoo/samuel",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      # Web server
      {:cowboy, "~> 1.0.0"},
      # Web app router and server connector
      {:plug, "~> 0.13"},
      # JSON encoder/decoder
      {:poison, "~> 1.4.0"},

      # BDD test framework
      {:shouldi, only: :test},
      # Automatic test runner
      {:mix_test_watch, "~> 0.1.2", only: :dev},


      # Markdown processor
      {:earmark, "~> 0.1", only: :dev},
      # Documentation generator
      {:ex_doc, "~> 0.7", only: :dev},
      # Documentation inspector
      {:inch_ex, only: ~w(dev docs)a},
    ]
  end
end
