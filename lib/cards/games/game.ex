defmodule Cards.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    belongs_to :room, Cards.Rooms.Room
    field :player_ids, {:array, :integer}

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:room_id, :player_ids])
    |> validate_required([:room_id, :player_ids])
  end
end
