defmodule CardsWeb.Router do
  use CardsWeb, :router

  pipeline :jwt_authenticated do
    plug Cards.UserManager.Pipeline
  end
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end
  pipeline :check_admin do
    plug Cards.UserManager.CheckAdmin
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CardsWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", CardsWeb do
    pipe_through [:api, :jwt_authenticated]

    resources "/users", UserController, except: [:new, :edit, :create]
    post "/registration", SessionController, :registration
    post "/login", SessionController, :login

    resources "/rooms", RoomController, except: [:new, :edit]
    resources "/games", GameController, except: [:new, :edit]
    resources "/players", PlayerController, except: [:new, :edit]
    resources "/decks", DeckController, except: [:new, :edit]
    resources "/hands", HandController, except: [:new, :edit]
    resources "/turns", TurnController, except: [:new, :edit]
  end

  pipeline :exq do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
    plug ExqUi.RouterPlug, namespace: "exq"
  end

  scope "/exq", ExqUi do
    pipe_through :exq

    forward "/", RouterPlug.Router, :index
  end
end
