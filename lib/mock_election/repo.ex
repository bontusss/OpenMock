defmodule MockElection.Repo do
  use Ecto.Repo,
    otp_app: :mock_election,
    adapter: Ecto.Adapters.Postgres
end
