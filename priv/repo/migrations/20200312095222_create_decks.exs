defmodule Cards.Repo.Migrations.CreateDecks do
  use Ecto.Migration

  def change do
    create table(:decks) do
      add :game_id, references(:games)
      add :deck, :map

      timestamps()
    end

  end
end
