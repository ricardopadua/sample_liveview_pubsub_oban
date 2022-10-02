defmodule Bear.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Bear.Repo,
      # Start the Telemetry supervisor
      BearWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bear.PubSub},
      # Start the Endpoint (http/https)
      BearWeb.Endpoint,
      # Start a worker by calling: Bear.Worker.start_link(arg)
      # {Bear.Worker, arg}
      {Oban, oban_config()} # Add this line
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bear.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp oban_config do # Add this line
    Application.fetch_env!(:bear, Oban)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BearWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
