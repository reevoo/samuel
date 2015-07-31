#!/bin/sh

MIX_ENV=prod elixir -S mix run -e "{:ok, _} = Plug.Adapters.Cowboy.http(Samuel.API, []); IO.puts \"Running on 4000.\"" --no-halt
