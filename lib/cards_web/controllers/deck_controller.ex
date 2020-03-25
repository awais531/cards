defmodule CardsWeb.DeckController do
  use CardsWeb, :controller

  alias Cards.Decks
  alias Cards.Decks.Deck

  action_fallback CardsWeb.FallbackController

  def index(conn, _params) do
    deck = Decks.list_deck()
#    decks = Enum.map(hd(deck).deck["deck"], &List.to_tuple(&1))
#    deck = [%{id: hd(deck).id, deck: decks}]
#    |> IO.inspect()
    render(conn, "index.json", deck: deck)
  end

  def create(conn, deck_params) do
    params = %{"deck" =>  deck_params["deck"]}
    with {:ok, %Deck{} = deck} <- Decks.create_deck(%{"game_id" => deck_params["game_id"], "deck" => params}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.deck_path(conn, :show, deck))
      |> render("show.json", deck: deck)
    end
  end

  def show(conn, %{"id" => id}) do
    deck = Decks.get_deck!(id)
    render(conn, "show.json", deck: deck)
  end

  def update(conn, %{"id" => id, "deck" => deck_params}) do
    deck = Decks.get_deck!(id)

    with {:ok, %Deck{} = deck} <- Decks.update_deck(deck, deck_params) do
      render(conn, "show.json", deck: deck)
    end
  end

  def delete(conn, %{"id" => id}) do
    deck = Decks.get_deck!(id)

    with {:ok, %Deck{}} <- Decks.delete_deck(deck) do
      send_resp(conn, :no_content, "")
    end
  end
end
