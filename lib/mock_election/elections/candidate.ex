defmodule MockElection.Elections.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "candidates" do
    field :name, :string
    field :bio, :string
    field :manifesto, :string

    belongs_to :election, MockElection.Elections.Election
    belongs_to :political_party, MockElection.Elections.PoliticalParty
    belongs_to :vice_candidate, MockElection.Elections.Candidate

    timestamps()
  end

  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [
      :name,
      :bio,
      :Manifesto,
      :election_id,
      :political_party_id,
      :vice_candidate_id
    ])
    |> validate_required([:name, :bio, :manifesto, :election_id, :political_party_id])
    |> foreign_key_constraint(:election_id)
    |> foreign_key_constraint(:political_party_id)
    |> foreign_key_constraint(:vice_candidate_id)
  end
end
