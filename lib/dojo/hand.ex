defmodule Dojo.Hand do
  alias Dojo.Card

  def score(cards) do
    evaluate(cards)
  end

  defp evaluate(cards) do

    cond do
      is_straight(cards) && is_same_suit(cards) ->
        :straight_flush
      is_straight(cards) ->
        :straight
      is_same_suit(cards) ->
        :flush
      true ->
        :high_card
    end
  end

  defp is_straight(cards) do
    # sort cards by rank
    # Map (reduce) through checking rank of n == rank of (n -1) +1 
  end

  defp is_same_suit(cards) do
    Enum.all?(tail, fn(%{rank: _, suit: suit}) -> suit == initialSuit end)
  end

end
