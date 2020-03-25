defmodule CardsWeb.PlayerView do
  use CardsWeb, :view
  alias CardsWeb.PlayerView

  def render("index.json", %{players: players}) do
    %{data: render_many(players, PlayerView, "player.json")}
  end

  def render("show.json", %{player: player}) do
    %{data: render_one(player, PlayerView, "player.json")}
  end

  def render("player.json", %{player: player}) do
    %{id: player.id,
      user_id: player.user_id,
      game_id: player.game_id}
  end
end
