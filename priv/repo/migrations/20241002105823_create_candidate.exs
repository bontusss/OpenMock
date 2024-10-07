defmodule MockElection.Repo.Migrations.CreateCandidate do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :name, :string
      add :bio, :string
      add :manifesto, :string

      add :election_id, references(:elections, on_delete: :delete_all)
      add :political_party_id, references(:political_parties, on_delete: :delete_all)
      add :vice_candidate_id, references(:candidates)

      timestamps()
    end

    create index(:candidates, [:election_id])
    create index(:candidates, [:political_party_id])
    create index(:candidates, [:vice_candidate_id])
  end
end
