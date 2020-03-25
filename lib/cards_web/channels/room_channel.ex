defmodule CardsWeb.RoomChannel do
  use CardsWeb, :channel

  alias Phoenix.Socket.Broadcast
  alias CardsWeb.Presence


  def join("room:" <> room_id, _params, socket) do
    room = Cards.Rooms.get_room!(room_id)
    if room == nil do
      {:error, %{reason: "room does not exist"}}
    else
      game = Cards.Games.get_game_by(room.id)
      IO.inspect(game.player_ids)
      IO.inspect(socket.assigns.player_id)
      {player_id, _} = Integer.parse(socket.assigns.player_id)
      if !Enum.member?(game.player_ids, player_id) do
        if length(game.player_ids) < 4 do
          {:ok, game} = Cards.Games.update_game(game, %{"player_ids" => game.player_ids ++ [player_id]})
          if length(game.player_ids) == 4 do
            {:ok, ack} = Exq.enqueue_in(Exq, "default", 30, Cards.StartGameWorker, [game.player_ids, Presence.list(socket)])
          end
          send self(), {:after_join, game.player_ids}
          {:ok, socket}
        else
          {:error, "room is full"}
        end
      else
        send self(), {:after_join, game.player_ids}
        {:ok, socket}
      end
    end
  end

  def handle_info({:after_join, player_ids}, socket) do
#    push(socket, "presence_state", Presence.list(socket))
    broadcast!( socket, "shout", %{player_id: socket.assigns.player_id, players: length(player_ids), presence: Presence.list(socket)} )
    {:ok, _} = Presence.track(socket, socket.assigns.player_id, %{})

    {:noreply, socket}
  end

#  def leave(%{assigns: assigns} = socket, "room:"<> room_id = topic) do
#    game = Cards.Games.get_game_by(room_id)
#    player_ids = Enum.filter(game.player_ids, fn p_id -> p_id != assigns.player_id end)
#    {:ok, game} = Cards.Games.update_game(game, %{"player_id" => player_ids})
##    Logger.debug "SOMEBODY LEAVING"
#    broadcast! socket, "shout", %{player_id: assigns.player_id, players: length(player_ids)}
#    {:ok, socket}
#  end
#
#  def handle_in("leave", _payload, %{assigns: assigns, topic: "room:" <> room_id} = socket) do
#    game = Cards.Games.get_game_by(room_id)
#    player_ids = Enum.filter(game.player_ids, fn p_id -> p_id != assigns.player_id end)
#    {:ok, game} = Cards.Games.update_game(game, %{"player_id" => player_ids})
#    broadcast! socket, "shout", %{player_id: assigns.player_id, players: length(player_ids)}
#    {:noreply, socket}
#  end

  def handle_in("shout", paylod, socket) do
    IO.inspect("======= broadcast ===========")
    broadcast!( socket, "shout", paylod )
    {:noreply, socket}
  end

#
#  def handle_in("room:create", players, %{assigns: assigns} = socket) do
#    IO.inspect("room:create = = = == = = = == = = == == = == = = == = = =")
#    IO.inspect(players)
#    push socket, "room:create", players
#
#    {:reply, {:ok, players}, socket}
#  end


    def handle_info(%Broadcast{topic: _, event: event, payload: payload}, socket) do
      push(socket, event, payload)
      {:noreply, socket}
    end
#  intercept ["new_player"]
#  def handle_out("new_player", payload, socket) do
#    push socket, "new_player", payload
#    {:noreply, socket}
#  end
  intercept ["presence_diff"]
  def handle_out("presence_diff", %{leaves: leaves} = msg, socket) do
    "room:" <> room_id = socket.topic
    # check if someone left
    case Enum.count(leaves) > 0 do
      true ->
        IO.inspect("++++++++++++leave+++++++++++")
            game = Cards.Games.get_game_by(room_id)
        IO.inspect(game)
            Enum.map(leaves, fn {k, _v} ->
              player_ids = Enum.filter(game.player_ids, fn p_id -> p_id != String.to_integer(k) end)
            IO.inspect(player_ids)
              {:ok, game} = Cards.Games.update_game(game, %{"player_ids" => player_ids})
              broadcast!( socket, "shout", %{player_id: k, players: length(player_ids), presence: Presence.list(socket)} )
            end)
        push(socket, "terminate", %{})
        {:noreply, socket}

      _ ->
#        push(socket, "presence_diff", msg)
        {:noreply, socket}
    end
  end
end






#    Enum.map(game.player_ids, fn p_id ->
#      {:ok, hand} =
#        Cards.Hands.create_hand(%{"player_id" => p_id, "game_id" => game.id, "deck_id" => deck.id})
#      hand
#    end)
#
#    Enum.zip(game.player_ids, hands) |> Enum.into(%{})
#        broadcast!(socket, "player:joined", %{players: game.players_ids})


#     && !Enum.member?(game.player_ids, socket.assigns.player_id)