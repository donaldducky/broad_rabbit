defmodule BroadRabbit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: BroadRabbit.Worker.start_link(arg)
      # {BroadRabbit.Worker, arg}
      BroadRabbit.MyBroadway,
      BroadRabbit.MySqs
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BroadRabbit.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
