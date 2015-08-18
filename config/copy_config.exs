use Mix.Config

config :samuel,
  guidelines_message: """
  *If you're new, read the [guidelines](https://github.com/reevoo/guidelines/blob/master/pull_requests.md).*

  Good code is **tested**, **easy to understand** and **able to cope when things go wrong**.

  Good pull requests are **descriptive**, **small** and **short-lived**.

  - [ ] Code has been reviewed.
  - [ ] Description explains what you have done and why.
  - [ ] Tests are green on CI (or pulled/tested on another machine).
  - [ ] Documentation has been created or updated.
  """
