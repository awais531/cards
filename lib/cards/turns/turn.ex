defmodule Cards.Turns.Turn do
  use Ecto.Schema
  import Ecto.Changeset

  schema "turns" do
    belongs_to :game, Cards.Games.Game
    belongs_to :hand, Cards.Hands.Hand
    field :played_card, :map
    belongs_to :player, Cards.Players.Player
    field :rest_hand, :map

    timestamps()
  end

  @doc false
  def changeset(turn, attrs) do
    turn
    |> cast(attrs, [:player_id, :game_id, :hand_id, :played_card, :rest_hand])
    |> validate_required([:player_id, :game_id, :hand_id, :played_card, :rest_hand])
  end
end
