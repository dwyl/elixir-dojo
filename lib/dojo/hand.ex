defmodule Dojo.Hand do
  alias Dojo.Card

  def score(cards) do
    evaluate(cards)
  end

  defp evaluate(cards) do
    cond do
      is_straight_flush?(cards) ->
        :straight_flush
      is_flush?(cards) ->
        :flush
      true ->
        :high_card
    end

  end

  defp is_straight_flush?(cards) do
    min = cards
    |> Enum.sort(&(&1.rank <= &2.rank))
    |> List.first()
    |> Map.get(:rank)

    list = Enum.to_list min..(min + 4)
    result = cards
    |> Enum.map(&(&1.rank in list))
    |> Enum.reduce(true, fn(x, acc) -> x && acc end)

    result
  end

  defp is_flush?(cards) do
    kind = cards
    |> List.first()
    |> Map.get(:suit)

    cards
    |> Enum.map(&(&1.suit == kind))
    |> Enum.reduce(true, fn(x, acc) -> x && acc end)
  end
end


# cards = [
#   %Card{rank: 10, suit: :hearts},
#   %Card{rank: 11, suit: :hearts},
#   %Card{rank: 12, suit: :hearts},
#   %Card{rank: 13, suit: :hearts},
#   %Card{rank: 14, suit: :hearts}
# ]
#
# assert Hand.score(cards) == :straight_flush
