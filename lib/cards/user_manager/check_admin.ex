defmodule Cards.UserManager.CheckAdmin do
  alias Cards.UserManager.ErrorHandler


  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)
    if current_user.is_admin == true do
      conn
    else
      conn
      |> ErrorHandler.auth_error(:unAuthorised)
      |> Plug.Conn.halt()
    end
  end

end
