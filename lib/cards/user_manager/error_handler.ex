defmodule Cards.UserManager.ErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    body = Jason.encode!(%{error: to_string(type)})
    send_resp(conn, 401, body)
  end
  def auth_error(conn, error) do
    body = Jason.encode!(%{error: to_string(error)})
    send_resp(conn, 401, body)
  end
end
