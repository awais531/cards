defmodule CardsWeb.GameController do
  use CardsWeb, :controller

  alias Cards.Games
  alias Cards.Games.Game
  alias Cards.Decks.Deck
  alias Cards.Rooms.Room

  action_fallback CardsWeb.FallbackController

  def index(conn, _params) do
    games = Games.list_games() |> IO.inspect()
    render(conn, "index.json", games: games)
  end

  def create(conn, game_params) do
    with {:ok, %Room{} = room} <- Cards.Rooms.create_room(%{"admin_id" => game_params["player_ids"]}),
         {:ok, %Game{} = game} <- Games.create_game(game_params) ,
         {:ok, %Deck{} = deck} <- Cards.Decks.create_deck(%{"game_id" => game.id, "deck" =>  Cards.Decks.DeckHelper.deck_params}) do

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.game_path(conn, :show, game))
      |> render("show.json", game: game)
    end
  end

  def show(conn, %{"id" => id}) do
    game = Games.get_game!(id)
    render(conn, "show.json", game: game)
  end

  def update(conn, %{"id" => id, "game" => game_params}) do
    game = Games.get_game!(id)

    with {:ok, %Game{} = game} <- Games.update_game(game, game_params) do
      render(conn, "show.json", game: game)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = Games.get_game!(id)

    with {:ok, %Game{}} <- Games.delete_game(game) do
      send_resp(conn, :no_content, "")
    end
  end
end
