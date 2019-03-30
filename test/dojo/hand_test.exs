defmodule Dojo.HandTest do
  use ExUnit.Case, async: true
  alias Dojo.Hand
  alias Dojo.Card
  doctest Dojo.Hand

  test "evaluates a straight flush" do
    cards = [
      %Card{rank: 9, suit: :hearts},
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 11, suit: :hearts},
      %Card{rank: 12, suit: :hearts},
      %Card{rank: 13, suit: :hearts}
    ]

    assert Hand.score(cards) == :straight_flush
  end

  test "evaluates flush of hearts" do
    cards = [
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 9, suit: :hearts},
      %Card{rank: 4, suit: :hearts},
      %Card{rank: 8, suit: :hearts},
      %Card{rank: 14, suit: :hearts}
    ]

    assert Hand.score(cards) == :flush
  end

  test "evaluates flush of spades" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 6, suit: :spades},
      %Card{rank: 5, suit: :spades},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 7, suit: :spades}
    ]

    assert Hand.score(cards) == :flush
  end

  test "does not evaluate flush for mismatching suits" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 12, suit: :diamonds},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 14, suit: :clubs}
    ]

    assert Hand.score(cards) != :flush
  end

  test "evaluates high card" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 11, suit: :spades}
    ]

    assert Hand.score(cards) == :high_card
  end

  test "evaluates royal flush of diamonds" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 12, suit: :diamonds},
      %Card{rank: 13, suit: :diamonds},
      %Card{rank: 14, suit: :diamonds}
    ]

    assert Hand.score(cards) == :royal_flush
  end

  test "does not evaluate royal flush for mismatching suits" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 12, suit: :diamonds},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 14, suit: :clubs}
    ]

    assert Hand.score(cards) != :royal_flush
  end

end
