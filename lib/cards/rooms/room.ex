defmodule Cards.Rooms.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    belongs_to :admin, Cards.Players.Player

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:admin_id])
    |> validate_required([:admin_id])
  end
end
