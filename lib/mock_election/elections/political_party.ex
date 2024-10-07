defmodule MockElection.Elections.PoliticalParty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "political_parties" do
    field :name, :string
    field :abbreviation, :string
    field :logo, :string

    has_many :candidates, MockElection.Elections.Candidate

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
  def changeset(political_party, attrs) do
    political_party
    |> cast(attrs, [:name, :abbreviation, :logo])
    |> validate_required([:name, :abbreiation, :logo])
    |> unique_constraint(:name)
    |> unique_constraint(:abbreviation)
  end
end
