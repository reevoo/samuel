defmodule Samuel do
  @moduledoc """
  Samuel is here to make sure your pull requests are all they can be.

  Don't piss him off.


  The entry point to the application is through the API, which can be found in
  the Samuel.API module.
  """

  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Thing.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Samuel.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
