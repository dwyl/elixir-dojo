defmodule Dojo.Hand do
  alias Dojo.Card

  def score(cards) do
    evaluate(cards)
  end

  defp evaluate(cards) do
    cond do
      is_royal_flush?(cards) ->
        :royal_flush
      is_straight_flush?(cards) ->
        :straight_flush
      is_flush?(cards) ->
        :flush
      is_straight?(cards) ->
        :straight
      is_pair?(cards) ->
        :pair
      true ->
        :high_card
    end

  end

  defp min_rank(cards) do
    cards
    |> Enum.sort(&(&1.rank <= &2.rank))
    |> List.first()
    |> Map.get(:rank)
  end

  defp is_straight?(cards) do
    min = min_rank(cards)
    list = Enum.to_list min..(min + 4)
    result = cards
    |> Enum.map(&(&1.rank in list))
    |> Enum.reduce(true, fn(x, acc) -> x && acc end)
  end

  defp is_straight_flush?(cards) do
    is_straight?(cards) && is_flush?(cards)
  end

  defp is_royal_flush?(cards) do
    is_straight_flush?(cards) && (min_rank(cards) == 10)
  end

  defp is_flush?(cards) do
    kind = cards
    |> List.first()
    |> Map.get(:suit)

    cards
    |> Enum.map(&(&1.suit == kind))
    |> Enum.reduce(true, fn(x, acc) -> x && acc end)
  end

  defp cardinality(cards) do
    ranks = cards
    |> Enum.map(&(&1.rank))

    numbers = ranks
    |> Enum.group_by(fn(x) -> x end)
    |> Enum.map(fn({_, val}) -> length val end)
  end

  defp is_pair?(cards) do
    numbers = cardinality(cards)
    2 in numbers
  end
end
