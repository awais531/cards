defmodule CardsWeb.TurnController do
  use CardsWeb, :controller

  alias Cards.Turns
  alias Cards.Turns.Turn

  action_fallback CardsWeb.FallbackController

  def index(conn, _params) do
    turns = Turns.list_turns()
    render(conn, "index.json", turns: turns)
  end

  def create(conn, %{"turn" => turn_params}) do
    with {:ok, %Turn{} = turn} <- Turns.create_turn(turn_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.turn_path(conn, :show, turn))
      |> render("show.json", turn: turn)
    end
  end

  def show(conn, %{"id" => id}) do
    turn = Turns.get_turn!(id)
    render(conn, "show.json", turn: turn)
  end

  def update(conn, %{"id" => id, "turn" => turn_params}) do
    turn = Turns.get_turn!(id)

    with {:ok, %Turn{} = turn} <- Turns.update_turn(turn, turn_params) do
      render(conn, "show.json", turn: turn)
    end
  end

  def delete(conn, %{"id" => id}) do
    turn = Turns.get_turn!(id)

    with {:ok, %Turn{}} <- Turns.delete_turn(turn) do
      send_resp(conn, :no_content, "")
    end
  end
end
