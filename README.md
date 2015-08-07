Samuel
======

[![Build Status](https://travis-ci.org/reevoo/samuel.svg?branch=master)](https://travis-ci.org/reevoo/samuel)
[![Inline docs](http://inch-ci.org/github/reevoo/samuel.svg?branch=master&style=flat)](http://inch-ci.org/github/reevoo/samuel)

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


## Read the docs

```sh
mix doc             # Generate the docs
open doc/index.html # View the docs
mix inch            # See how the docs might be improved
```


## Run the tests

```sh
mix test       # run tests once
mix test watch # run tests on file changes
```


## Run the server

Run the REPL.

```sh
iex -S mix
```

You can run the server from the REPL like this:

```elixir
Samuel.API.Server.start
```

Code is not automatically reloaded.


## LICENCE

```
Samuel - Angry Pull request bot
Copyright © 2015 Reevoo

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
