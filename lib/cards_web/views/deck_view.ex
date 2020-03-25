defmodule CardsWeb.DeckView do
  use CardsWeb, :view
  alias CardsWeb.DeckView

  def render("index.json", %{deck: deck}) do
    %{data: render_many(deck, DeckView, "deck.json")}
  end

  def render("show.json", %{deck: deck}) do
    %{data: render_one(deck, DeckView, "deck.json")}
  end

  def render("deck.json", %{deck: deck}) do
    %{id: deck.id,
      deck: render_many(deck.deck["deck"], DeckView, "deck_list.json")
    }
  end
  def render("deck_list.json", %{deck: deck}) do
    deck
  end
end
