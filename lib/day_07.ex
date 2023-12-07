defmodule Day07 do
  def parse(input) do
    input
    |> Enum.map(fn line ->
      [hand, bid] = String.split(line, " ")
      bid = ParseHelper.get_number(bid)

      {hand, bid}
    end)
  end

  def add_jokers(cards) do
    jokers = Map.get(cards, "J", 0)

    case jokers do
      5 ->
        cards |> Map.values()

      _ ->
        cards_without_jokers =
          cards
          |> Map.filter(fn {key, _} -> key != "J" end)
          |> Map.values()
          |> Enum.sort(:desc)

        [hd(cards_without_jokers) + jokers | tl(cards_without_jokers)]
    end
  end

  def get_strength(hand, joker \\ false) do
    cards = hand |> String.graphemes() |> Enum.frequencies()

    cards =
      case joker do
        true -> add_jokers(cards)
        false -> cards |> Map.values()
      end

    cond do
      Enum.member?(cards, 5) -> 1
      Enum.member?(cards, 4) -> 2
      Enum.member?(cards, 3) && Enum.member?(cards, 2) -> 3
      Enum.member?(cards, 3) -> 4
      Enum.count(cards, fn c -> c == 2 end) == 2 -> 5
      Enum.member?(cards, 2) -> 6
      true -> 7
    end
  end

  def get_relative_strength(hand, joker \\ false) do
    hand
    |> String.graphemes()
    |> Enum.map(fn card ->
      case card do
        "A" -> 1
        "K" -> 2
        "Q" -> 3
        "J" when not joker -> 4
        "T" -> 5
        "9" -> 6
        "8" -> 7
        "7" -> 8
        "6" -> 9
        "5" -> 10
        "4" -> 11
        "3" -> 12
        "2" -> 13
        "J" when joker -> 14
      end
    end)
  end

  def calc_strength(hands, joker \\ false) do
    hands
    |> Enum.map(fn {hand, bid} ->
      strength = {get_strength(hand, joker), get_relative_strength(hand, joker)}
      {hand, strength, bid}
    end)
  end

  def rank(hands) do
    Enum.sort_by(hands, fn {_, strength, _} -> strength end, :desc)
  end

  def calc_winnings(hands) do
    hands
    |> Enum.with_index()
    |> Enum.map(fn {{_, _, bid}, index} -> bid * (index + 1) end)
    |> Enum.sum()
  end

  def solve_a(input) do
    input
    |> parse
    |> calc_strength
    |> rank
    |> calc_winnings
  end

  def solve_b(input) do
    input
    |> parse
    |> calc_strength(true)
    |> rank
    |> calc_winnings
  end
end
