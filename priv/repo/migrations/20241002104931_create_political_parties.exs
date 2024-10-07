defmodule MockElection.Repo.Migrations.CreatePoliticalParties do
  use Ecto.Migration

  def change do
    create table(:political_parties) do
      add :name, :string
      add :abbreviation, :string
      add :logo, :string

      timestamps()
    end

    create unique_index(:political_parties, [:name])
    create unique_index(:political_parties, [:abbreviation])
  end
end
