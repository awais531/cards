defmodule Cards.StartGameWorker do
  alias Cards.Decks.DeckHelper, as: Deck
  alias CardsWeb.Presence

  def perform(player_ids, presence) do

    IO.inspect("====================== After 10 sec  =======================")
    IO.inspect(player_ids)
    deck = Deck.shuffled()
    {hands, deck_} = Deck.hand_serve(deck, 4)
    IO.inspect()
    #    {:ok, deck} = Cards.Decks.create_deck(%{"game_id" => game.id, "deck" => deck})
#    IO.inspect(hands)
    IO.inspect(Enum.zip(player_ids, hands) |> Enum.into(%{}))
#    IO.inspect(deck_)
    IO.inspect presence
  end
end