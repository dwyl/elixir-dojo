defmodule Dojo.Hand do

  def score(cards) do
    sorted_cards = Enum.sort(cards, fn c, n -> c.rank <= n.rank end)
    evaluate(sorted_cards)
  end

  defp evaluate(cards) do
    suits = Enum.map(cards, fn card -> card.suit end)
    ranks = Enum.map(cards, fn card -> card.rank end)
    # IO.inspect(ranks)
    # IO.puts Enum.at(ranks, 1)

    cond do
      # royal flush:
      same_suit?(suits) && consecutive_ranks?(ranks) && Enum.at(ranks, 0) == 10 ->
        :royal_flush
      same_suit?(suits) && consecutive_ranks?(ranks) ->
        :straight_flush
      of_a_kind?(cards, 4) ->
        :four_of_a_kind
      of_a_kind?(cards, 3) && of_a_kind?(cards, 2) ->
        :full_house
      same_suit?(suits) ->
        :flush
      consecutive_ranks?(ranks) ->
        :straight
      of_a_kind?(cards, 3) ->
        :three_of_a_kind
      true ->
        :high_card
    end
  end

  def of_a_kind?(cards, x) do
    cards
    |> Enum.group_by(fn c -> c.rank end)
    |> Stream.map(fn {rank, cards} -> {rank, Enum.count(cards)} end)
    |> Enum.any?(fn {_rank, n} -> n == x end)
  end

  def same_suit?(suits) do
    first_suit = Enum.fetch!(suits, 0)
    Enum.all?(suits, fn suit -> suit == first_suit end)
  end

  def consecutive_ranks?([cur_rank, next_rank | rem_ranks]) do
    next_rank - cur_rank == 1 && consecutive_ranks?([next_rank | rem_ranks])
  end
  def consecutive_ranks?(_), do: true
end
