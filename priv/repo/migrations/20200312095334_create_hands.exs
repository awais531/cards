defmodule Cards.Repo.Migrations.CreateHands do
  use Ecto.Migration

  def change do
    create table(:hands) do
      add :player_id, references(:players)
      add :game_id, references(:games)
      add :deck_id, references(:decks)

      timestamps()
    end

  end
end
