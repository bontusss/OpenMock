defmodule MockElection.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :election_id, references(:elections, on_delete: :delete_all)
      add :candidate_id, references(:candidates, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:votes, [:user_id, :election_id], name: :user_id_election_id_index)
  end
end
