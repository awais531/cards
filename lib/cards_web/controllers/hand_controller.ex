defmodule CardsWeb.HandController do
  use CardsWeb, :controller

  alias Cards.Hands
  alias Cards.Hands.Hand

  action_fallback CardsWeb.FallbackController

  def index(conn, _params) do
    hands = Hands.list_hands()
    render(conn, "index.json", hands: hands)
  end

  def create(conn, %{"hand" => hand_params}) do
    with {:ok, %Hand{} = hand} <- Hands.create_hand(hand_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.hand_path(conn, :show, hand))
      |> render("show.json", hand: hand)
    end
  end

  def show(conn, %{"id" => id}) do
    hand = Hands.get_hand!(id)
    render(conn, "show.json", hand: hand)
  end

  def update(conn, %{"id" => id, "hand" => hand_params}) do
    hand = Hands.get_hand!(id)

    with {:ok, %Hand{} = hand} <- Hands.update_hand(hand, hand_params) do
      render(conn, "show.json", hand: hand)
    end
  end

  def delete(conn, %{"id" => id}) do
    hand = Hands.get_hand!(id)

    with {:ok, %Hand{}} <- Hands.delete_hand(hand) do
      send_resp(conn, :no_content, "")
    end
  end
end
