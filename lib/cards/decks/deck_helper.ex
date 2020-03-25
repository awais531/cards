defmodule Cards.Decks.DeckHelper do

  @faces [2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "Q", "K", "A"]

  @suits ~w(Hearts Clubs Diamonds Spades)

  @deck for face <- @faces, suit <- @suits, do: [suit, face]          # list of list
#  @deck for face <- @faces, suit <- @suits, do: {suit, face}         # list of tuple
#  @deck for face <- @faces, suit <- @suits, do: %{"#{suit}": face}   # list of map

  def new do
    @deck
  end

  def shuffled do
    shuffle()
  end
  def deck_params() do
    %{"deck" =>  shuffled}
  end
  #    Shuffles the `deck` using the modern version of the Fisher–Yates shuffle algorithm.

  def shuffle(deck \\ new()) when is_list(deck) do
    do_shuffle(deck, length(deck), [])
  end

  defp do_shuffle([last_card | _empty_deck], 1, shuffled_deck), do: [last_card | shuffled_deck]

  defp do_shuffle(deck, cards_left, shuffled_deck) do
    random_card_index = :rand.uniform(cards_left) - 1
    random_card = Enum.at(deck, random_card_index)
    {current_last_card, deck_leftovers} = List.pop_at(deck, -1)

    deck_leftovers
    |> List.replace_at(random_card_index, current_last_card)
    |> do_shuffle(cards_left - 1, [random_card | shuffled_deck])
  end

#    def deal(deck, n_cards) when is_list(deck) and is_integer(n_cards) and n_cards > 0 do
#      deck
#      |> Enum.split(n_cards)
#    end


  def hand_serve(deck, n_cards) when is_list(deck) and is_integer(n_cards) and n_cards > 0 do
    {p1, deck_} = deck
                  |> Enum.split(n_cards)
    {p2, deck_} = deck_
                  |> Enum.split(n_cards)
    {p3, deck_} = deck_
                  |> Enum.split(n_cards)
    {p4, deck_} = deck_
                  |> Enum.split(n_cards)
    {[p1, p2, p3, p4], deck_}
  end

#  alias Cards.Decks.Deck
#  def test() do
#  Cards.Decks.create_deck(%{})
##  Cards.Repo.insert(%Deck{deck: new(), valid: true})
#  end
end
#   import Cards.Decks.DeckHelper
##   params = %{"deck" =>  shuffled}
#   params = %{"deck" =>  Enum.map(shuffled, &Tuple.to_list(&1))}
#   Cards.Decks.create_deck(%{"deck" => params})
#   Cards.Decks.create_deck(%{"game_id" => 1, "deck" => shuffled})