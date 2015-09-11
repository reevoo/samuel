use Mix.Config

config :samuel,
  guidelines_message: """
  *If you're new, read the [guidelines](https://github.com/reevoo/guidelines/blob/master/pull_requests.md).*

  Good code is **tested**, **easy to understand** and **able to cope when things go wrong**.

  Good pull requests are **descriptive**, **small** and **short-lived**.

  **For the Author**
  - [ ] Description explains what you have done and why.
  - [ ] Tests have been written (or you have explained why you don't need tests).
  - [ ] Documentation/comments have been added/updated.

  **For the Reviewer**
  - [ ] Tests are green on CI (or pulled/tested on your machine).
  - [ ] Tests cover happy and unhappy paths in the code.
  - [ ] The code is easy to understand.
  """
