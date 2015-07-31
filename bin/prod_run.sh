#!/bin/sh

MIX_ENV=prod elixir -S mix run -e "Samuel.API.Server.start"
