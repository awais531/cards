defmodule CardsWeb.SessionController do
  use CardsWeb, :controller

  alias Cards.{Accounts, UserManager.Guardian}

  def registration(conn, params) do
    case Accounts.create_user(params) do
      {:ok, user}->
        Cards.Players.create_player(%{"user_id" => user.id})
        {:ok, token, _claims} =  Guardian.encode_and_sign(user)
        render(conn, "jwt.json", jwt: token)
      {:error, changeset}->
        render(conn, "error.json", changeset: changeset)
    end
  end

  def login(conn, params) do
    user_login = Guardian.Plug.current_resource(conn)
    if user_login do
      render(conn, "user.json", user: user_login)
    else
      case Accounts.authenticate_user(params["username"], params["password"]) do
        {:ok, user} ->
          {:ok, token, _claims} =  Guardian.encode_and_sign(user)
          render(conn, "jwt.json", jwt: token)
        {:error, reason} ->
          render(conn, "error.json", error: reason)
      end
    end
  end

#  def logout(conn, _) do
#    conn
#    |> Guardian.Plug.sign_out()
#    render(conn, "message.json", msg: "logout")
#  end

end