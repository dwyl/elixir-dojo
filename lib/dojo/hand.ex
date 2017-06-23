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

  # defp sort_by_rank(cards) do
  #   Enum.sort(cards, fn(%{_: _, suit: suit}) -> ... end)
  # end

  defp is_same_suit([ %{suit: initialSuit} | tail]) do
    Enum.all?(tail, fn(%{suit: suit}) -> suit == initialSuit end)
  end

end
