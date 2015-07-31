Samuel
======

Samuel is here to make sure your pull requests are all they can be. He will:

* Post guidelines to your pull requests (soon)

And in future, he'll maybe do more.

* Moan at you if you merge your pull request without code reviews.
* Moan at you if you leave your pull requests open for a long time.
* Have a cool logo.


## Install it

```sh
brew install elixir # Install Elixir
mix deps.get        # Download the dependencies
```


## Test it

```sh
mix test       # run tests once
mix test watch # run tests on file changes
```


## Run it

Run the REPL.

```sh
iex -S mix
```

You can run the server from the REPL like this:

```elixir
Samuel.API.Server.start
```

Code is not automatically reloaded.
