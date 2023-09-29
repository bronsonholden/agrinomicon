defmodule Agrinomicon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AgrinomiconWeb.Telemetry,
      # Start the Ecto repository
      Agrinomicon.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Agrinomicon.PubSub},
      # Start Finch
      {Finch,
       name: Agrinomicon.Finch,
       pools: %{
         default: [
           conn_opts: [
             # work around cert issue with USDA CDL server
             transport_opts: [verify: :verify_none]
           ]
         ]
       }},
      # Start the Endpoint (http/https)
      AgrinomiconWeb.Endpoint,
      # Start a worker by calling: Agrinomicon.Worker.start_link(arg)
      # {Agrinomicon.Worker, arg}
      {Oban, Application.fetch_env!(:agrinomicon, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Agrinomicon.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AgrinomiconWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
