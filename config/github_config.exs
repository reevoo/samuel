use Mix.Config

github_access_key = case Mix.env do
  :prod     -> System.get_env "GITHUB_ACCESS_KEY"
  otherwise -> "DUMMY-GITHUB-ACCESS-KEY"
end

config :samuel,
  github_access_key: github_access_key
