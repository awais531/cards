defmodule Cards.Decks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  schema "decks" do
    field :deck, :map
    belongs_to :game, Cards.Games.Game
    timestamps()
  end

  @doc false
  def changeset(deck, attrs) do
    deck
    |> cast(attrs, [:deck, :game_id])
    |> validate_required([:deck, :game_id])
  end
end

