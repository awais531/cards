defmodule Cards.Repo.Migrations.AddAdminIdInRooms do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :admin_id, references(:players)

    end
  end
end
