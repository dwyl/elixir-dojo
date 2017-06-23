defmodule Dojo.Hand do
  alias Dojo.Card

  def score(cards) do
    evaluate(cards)
  end

  defp sort_cards(cards) do
    Enum.sort(cards)
  end

  defp evaluate(hand) do
    sorted_hand = sort_cards(hand)
    [first_card | tail] = sorted_hand
    check_suit(first_card, tail, hand)
  end

  defp check_suit(card, [], hand) do
    # suit is all the same
    :flush
  end

  defp check_suit(first_card, list, hand) do
    [next_card | rest] = list
    case first_card.suit == next_card.suit do
      true ->
        check_suit(next_card, rest, hand)
      false ->
        # not all suits are same go here
        :high_card
    end
  end

end

# cards = [
#   %{rank: 13, suit: :hearts},
#   %{rank: 10, suit: :hearts},
#   %{rank: 11, suit: :hearts},
#   %{rank: 12, suit: :hearts},
#   %{rank: 14, suit: :hearts}
# ]
