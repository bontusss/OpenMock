defmodule MockElection.Elections.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    belongs_to :user, MockElection.Accounts.User
    belongs_to :election, MockElection.Elections.Election
    belongs_to :candidate, MockElection.Elections.Candidate

    timestamps()
  end

  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:user_id, :election_id, :candidate_id])
    |> validate_required([:user_id, :election_id, :candidate_id])
    |> unique_constraint([:user_id, :election_id], name: :user_id_election_id_index)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:electioon_id)
    |> foreign_key_constraint(:candidate_id)
  end
end
