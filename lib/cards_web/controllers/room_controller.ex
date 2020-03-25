defmodule CardsWeb.RoomController do
  use CardsWeb, :controller

  alias Cards.Rooms
  alias Cards.Rooms.Room
  alias Cards.Games
  alias Cards.Games.Game

  action_fallback CardsWeb.FallbackController

  def index(conn, _params) do
    rooms = Rooms.list_rooms()
    render(conn, "index.json", rooms: rooms)
  end

  def create(conn, room_params) do
    with {:ok, %Room{} = room} <- Rooms.create_room(room_params),
         {:ok, %Game{} = game} <- Games.create_game(%{"player_ids" => [room.admin_id], "room_id" => room.id}) do
#        CardsWeb.Endpoint.broadcast("room:" <> room.id, "shout", %{player_id: room.admin_id, players: 1})
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.room_path(conn, :show, room))
      |> render("show.json", room: room)
    end
  end

  def show(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)
    render(conn, "show.json", room: room)
  end

  def update(conn, %{"id" => id, "room" => room_params}) do
    room = Rooms.get_room!(id)

    with {:ok, %Room{} = room} <- Rooms.update_room(room, room_params) do
      render(conn, "show.json", room: room)
    end
  end

  def delete(conn, %{"id" => id}) do
    room = Rooms.get_room!(id)

    with {:ok, %Room{}} <- Rooms.delete_room(room) do
      send_resp(conn, :no_content, "")
    end
  end
end
