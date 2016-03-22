use Mix.Config

github_access_key = case Mix.env do
  :test     -> "DUMMY-GITHUB-ACCESS-KEY"
  otherwise -> System.get_env "GITHUB_ACCESS_KEY"
end

org_name = case Mix.env do
  :test     -> "DUMMY-GITHUB-ORG-NAME"
  otherwise -> System.get_env "GITHUB_ORG_NAME"
end

config :samuel,
  github_access_key: github_access_key,
  github_org_name: org_name
