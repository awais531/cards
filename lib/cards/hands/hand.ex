defmodule Cards.Hands.Hand do
  use Ecto.Schema
  import Ecto.Changeset

  schema "hands" do
    belongs_to :deck, Cards.Decks.Deck
    belongs_to :game, Cards.Games.Game
    belongs_to :player, Cards.Players.Player

    timestamps()
  end

  @doc false
  def changeset(hand, attrs) do
    hand
    |> cast(attrs, [:player_id, :game_id, :deck_id])
    |> validate_required([:player_id, :game_id, :deck_id])
  end
end
