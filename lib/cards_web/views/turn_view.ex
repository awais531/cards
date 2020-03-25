defmodule CardsWeb.TurnView do
  use CardsWeb, :view
  alias CardsWeb.TurnView

  def render("index.json", %{turns: turns}) do
    %{data: render_many(turns, TurnView, "turn.json")}
  end

  def render("show.json", %{turn: turn}) do
    %{data: render_one(turn, TurnView, "turn.json")}
  end

  def render("turn.json", %{turn: turn}) do
    %{id: turn.id,
      player_id: turn.player_id,
      game_id: turn.game_id,
      hand_id: turn.hand_id,
      played_card: turn.played_card,
      rest_hand: turn.rest_hand}
  end
end
