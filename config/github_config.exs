use Mix.Config

github_access_key = case Mix.env do
  :test     -> "DUMMY-GITHUB-ACCESS-KEY"
  otherwise -> System.get_env "GITHUB_ACCESS_KEY"
end

config :samuel,
  github_access_key: github_access_key
