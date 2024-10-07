defmodule MockElection.Elections.Election do
  use Ecto.Schema
  import Ecto.Changeset

  schema "elections" do
    field :type, Ecto.Enum, values: [:state, :parliamentary, :national]
    field :start_date, :utc_datetime
    field :end_date, :utc_datetime
    field :state, :string
    field :country, :string
    field :result, :map
    field :registered_voters, :integer, default: 0
    field :total_votes, :integer, default: 0

    has_many :candidates, MockElection.Candidate
    has_many :votes, MockElection.Vote

    timestamps()
  end

  @spec changeset(
          {map(),
           %{
             optional(atom()) =>
               atom()
               | {:array | :assoc | :embed | :in | :map | :parameterized | :supertype | :try,
                  any()}
           }}
          | %{
              :__struct__ => atom() | %{:__changeset__ => map(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  @spec changeset(
          {map(),
           %{
             optional(atom()) =>
               atom()
               | {:array | :assoc | :embed | :in | :map | :parameterized | :supertype | :try,
                  any()}
           }}
          | %{
              :__struct__ => atom() | %{:__changeset__ => map(), optional(any()) => any()},
              optional(atom()) => any()
            },
          :invalid | %{optional(:__struct__) => none(), optional(atom() | binary()) => any()}
        ) :: Ecto.Changeset.t()
  def changeset(election, attrs) do
    election
    |> cast(attrs, [:type, :start_date, :end_date, :state, :country])
    |> validate_required([:type, :start_date, :end_date, :country])
    |> validate_inclusion(:type, [:state, :parliamentary, :national])
    |> validate_state_if_needed()
  end

  defp validate_state_if_needed(changeset) do
    type = get_field(changeset, :type)

    if type in [:state, :parliamentary] do
      validate_required(changeset, [:state])
    else
      changeset
    end
  end
end
