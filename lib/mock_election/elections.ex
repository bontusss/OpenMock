defmodule MockElection.Elections do
  import Ecto.Query
  alias MockElection.Repo
  alias MockElection.Elections.{Election, Candidate, PoliticalParty, Vote}
  alias MockElection.Accounts.User

  def create_election(%User{role: "admin"} = admin, attrs) do
    %Election{}
    |> Election.changeset(attrs)
    |> Repo.insert()
  end

  def add_candidate_to_election(election_id, attrs) do
    election = Repo.get!(Election, election_id)

    %Candidate{}
    |> Candidate.changeset(Map.put(attrs, "election_id", election.id))
    |> Repo.insert()
  end

  def cast_vote(%User{} = user, election_id, candidate_id) do
    election = Repo.get!(Election, election_id)

    if can_vote?(user, election) do
      %Vote{}
      |> Vote.changeset(%{user_id: user.id, election_id: election_id, candidate_id: candidate_id})
      |> Repo.insert()
      |> case do
        {:ok, vote} ->
          update_vote_count(election)
          {:ok, vote}

        error ->
          error
      end
    else
      {:error, :not_eligible}
    end
  end

  defp can_vote?(user, election) do
    case election.type do
      :national -> true
      :state -> user.state == election.state
      :parliamentary -> user.state == election.state
    end
  end

  defp update_vote_count(election) do
    total_votes = Repo.aggregate(from(v in Vote, where: v.election_id == ^election.id), :count)

    election
    |> Ecto.Changeset.change(%{total_votes: total_votes})
    |> Repo.insert()
  end

  def get_election_results(election_id) do
    query =
      from v in Vote,
        where: v.election_id == ^election_id,
        group_by: v.candidate_id,
        select: {v.candidate_id, count(v.id)},
        order_by: [desc: count(v.id)]

    results = Repo.all(query)

    Enum.map(results, fn candidate_id, votes ->
      candidate = Repo.get!(Candidate, candidate_id) |> Repo.preload(:political_party)

      %{
        candidate: candidate.name,
        party: candidate.political_party.name,
        votes: votes
      }
    end)
  end
end
