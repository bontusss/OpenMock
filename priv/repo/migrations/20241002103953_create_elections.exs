defmodule MockElection.Repo.Migrations.CreateElections do
  use Ecto.Migration

  def change do
    create table(:elections) do
      add :type, :string # Ecto Enum will be handled as a string or use custom type
      add :start_date, :utc_datetime
      add :end_date, :utc_datetime
      add :state, :string
      add :country, :string
      add :result, :map
      add :registered_voters, :integer, default: 0
      add :total_votes, :integer, default: 0

      timestamps()
    end

    create index(:elections, [:type])
  end
end
