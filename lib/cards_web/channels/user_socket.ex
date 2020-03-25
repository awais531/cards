defmodule CardsWeb.UserSocket do
  use Phoenix.Socket
alias Cards.UserManager.Guardian
alias Cards.{Repo,Players.Player}
  ## Channels
   channel "room:*", CardsWeb.RoomChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.

  def connect(%{"id" => id}, socket, _connect_info) do
    {:ok, assign( socket, :player_id, id)}
  end

#  user_id = 2
#  token = Phoenix.Token.sign(CardsWeb.Endpoint, "user salt", user_id)
#  Phoenix.Token.verify(CardsWeb.Endpoint, "user salt", token, max_age: 86400)
#  Guardian.decode_and_verify(token)

  def connect(%{"token" => token}, socket) do
    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        player = Repo.get_by(Player, user_id: claims["sub"])
        {:ok, assign(socket, :player_id, player.id)}
      {:error, _reason} ->
        :error
    end
  end
  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
       def id(socket), do: "user_socket:#{socket.assigns.player_id}"
  #
#   Would allow you to broadcast a "disconnect" event and terminate
#   all active sockets and channels for a given user:
#
#       CardsWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
#
#   Returning `nil` makes this socket anonymous.
#  def id(_socket), do: nil
end
