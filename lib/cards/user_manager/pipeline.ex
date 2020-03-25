defmodule Cards.UserManager.Pipeline do
  use Guardian.Plug.Pipeline,
      otp_app: :cards,
      module: Cards.UserManager.Guardian,
      error_handler: Cards.UserManager.ErrorHandler


  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession
  # If there is an authorization header, restrict it to an access token and validate it
  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end