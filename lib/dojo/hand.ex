defmodule Dojo.Hand do
  alias Dojo.Card

  def score(cards) do
    check_of_a_kind(cards)
  end

  defp check_of_a_kind(cards) do
    cards
    |> Enum.uniq_by(&(&1.rank))
    |> Enum.count
    |> case do
      3 -> :three_of_a_kind
      2 -> check_full_house(cards)
      _ -> check_flush(cards)
    end
  end

  defp check_full_house(cards) do
    :four_of_a_kind
  end

  defp check_flush(cards) do
    cards
    |> Enum.uniq_by(&(&1.suit))
    |> Enum.count
    |> case do
      1 -> get_flush_type(cards)
      _ -> evaluate(cards)
    end
  end

  def get_flush_type(cards) do
    sorted_cards =
    cards
    |> Enum.map(&(&1.rank))
    |> Enum.sort

    sorted_cards
    |> is_straight_or_royal
    |> case do
      true ->
        Enum.sum(sorted_cards)
          |> case do
            60 -> :royal_flush
            _ -> :straight_flush
          end
      false -> :flush
    end
  end

  def is_straight_or_royal(cards) do
    cards == Enum.to_list(Enum.at(cards, 0)..Enum.at(cards, length(cards) - 1))
  end

  defp evaluate(_), do: :high_card
end
