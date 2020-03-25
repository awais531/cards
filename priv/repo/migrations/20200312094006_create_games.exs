defmodule Cards.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :room_id, references(:rooms)
      add :player_ids, {:array, :integer}
      timestamps()
    end

  end
end
