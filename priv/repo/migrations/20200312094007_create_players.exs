defmodule Cards.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players, primary_key: false) do
      add :id, :id, primary_key: true
      add :user_id, references(:users)

      timestamps()
    end

  end
end
