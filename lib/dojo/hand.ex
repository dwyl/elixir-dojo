defmodule Dojo.Hand do
  alias Dojo.Card

  def score(cards) do
    evaluate(cards)
  end

  defp evaluate(_), do: :high_card
end
