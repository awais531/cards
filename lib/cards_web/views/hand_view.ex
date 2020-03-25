defmodule CardsWeb.HandView do
  use CardsWeb, :view
  alias CardsWeb.HandView

  def render("index.json", %{hands: hands}) do
    %{data: render_many(hands, HandView, "hand.json")}
  end

  def render("show.json", %{hand: hand}) do
    %{data: render_one(hand, HandView, "hand.json")}
  end

  def render("hand.json", %{hand: hand}) do
    %{id: hand.id,
      player_id: hand.player_id,
      game_id: hand.game_id,
      deck_id: hand.deck_id}
  end
end
