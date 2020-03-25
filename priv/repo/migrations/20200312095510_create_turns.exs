defmodule Cards.Repo.Migrations.CreateTurns do
  use Ecto.Migration

  def change do
    create table(:turns) do
      add :player_id, references(:players)
      add :game_id, references(:games)
      add :hand_id, references(:hands)
      add :played_card, :map
      add :rest_hand, :map

      timestamps()
    end

  end
end
