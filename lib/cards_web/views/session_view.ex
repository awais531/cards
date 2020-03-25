defmodule CardsWeb.SessionView do
  use CardsWeb, :view
  alias CardsWeb.SessionView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, SessionView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, SessionView, "user.json")}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{jwt: jwt}
  end

  def render("error.json", %{error: error}) do
    %{error: error}
  end
end
