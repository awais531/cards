defmodule Cards.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms) do
#      add :admin_id, references(:players)

      timestamps()
    end

  end
end
