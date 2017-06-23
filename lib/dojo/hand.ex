defmodule Dojo.Hand do
  alias Dojo.Card

  def score(cards) do
    evaluate(cards)
  end

  defp evaluate(_), do: :high_card

  def cards, do: [
    %Card{rank: 1, suit: :hearts},
    %Card{rank: 2, suit: :hearts},
    %Card{rank: 4, suit: :hearts},
    %Card{rank: 3, suit: :spades}
  ]

  def all_same_suit?([first | other_cards]) do
    Enum.all?(other_cards, fn card -> card.suit == first.suit end)
  end

  def is_sequence?(cards) do
    cards
    |> Enum.sort_by(fn card -> card.rank end)
  end


  def is_next?(true, []), do: true
  def is_next?(_, [a | [ b | t ] ]) do
    is_next?(a.rank == b.rank + 1, [b | t])
  end

  def is_next?(true, [a | b]), do: a.rank == b.rank + 1
  def is_next?(false, _), do: false
end
