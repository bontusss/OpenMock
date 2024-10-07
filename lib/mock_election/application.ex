defmodule MockElection.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MockElectionWeb.Telemetry,
      MockElection.Repo,
      {DNSCluster, query: Application.get_env(:mock_election, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MockElection.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MockElection.Finch},
      # Start a worker by calling: MockElection.Worker.start_link(arg)
      # {MockElection.Worker, arg},
      # Start to serve requests, typically the last entry
      MockElectionWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MockElection.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MockElectionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
