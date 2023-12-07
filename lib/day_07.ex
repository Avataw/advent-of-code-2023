defmodule Day07 do
  def parse(input) do
    input
    |> Enum.map(fn line ->
      [hand, bid] = String.split(line, " ")
      {result, _} = Integer.parse(bid)

      {hand, result}
    end)
  end

  def get_strength(hand) do
    cards =
      String.graphemes(hand)
      |> Enum.frequencies()
      |> Map.values()

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

  def get_relative_strength(card) do
    case card do
      "A" -> 1
      "K" -> 2
      "Q" -> 3
      "J" -> 4
      "T" -> 5
      "9" -> 6
      "8" -> 7
      "7" -> 8
      "6" -> 9
      "5" -> 10
      "4" -> 11
      "3" -> 12
      "2" -> 13
    end
  end

  def solve_a(input) do
    input
    |> parse
    |> Enum.map(fn {hand, bid} ->
      strength = get_strength(hand)
      {hand, strength, bid}
    end)
    |> Enum.sort_by(fn {hand, strength, _} ->
      relative_strength = hand |> String.graphemes() |> Enum.map(&get_relative_strength/1)
      {strength, relative_strength}
    end)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {{_, _, bid}, index}, acc ->
      acc + bid * (index + 1)
    end)
  end

  @spec get_strength_with_jokers(binary()) :: 1 | 2 | 3 | 4 | 5 | 6 | 7
  def get_strength_with_jokers(hand) do
    jokers = String.graphemes(hand) |> Enum.count(fn card -> card == "J" end)

    cards =
      if String.graphemes(hand) |> Enum.all?(fn card -> card == "J" end) do
        hand
        |> String.graphemes()
        |> Enum.frequencies()
        |> Map.values()
        |> Enum.sort(:desc)
      else
        temp =
          hand
          |> String.graphemes()
          |> Enum.reject(fn card -> card == "J" end)
          |> Enum.frequencies()
          |> Map.values()
          |> Enum.sort(:desc)

        [hd(temp) + jokers | tl(temp)]
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

  def get_relative_strength_b(card) do
    case card do
      "A" -> 1
      "K" -> 2
      "Q" -> 3
      "T" -> 4
      "9" -> 5
      "8" -> 6
      "7" -> 7
      "6" -> 8
      "5" -> 9
      "4" -> 10
      "3" -> 11
      "2" -> 12
      "J" -> 13
    end
  end

  def solve_b(input) do
    input
    |> parse
    |> Enum.map(fn {hand, bid} ->
      strength = get_strength_with_jokers(hand)
      {hand, strength, bid}
    end)
    |> Enum.sort_by(fn {hand, strength, _} ->
      relative_strength = hand |> String.graphemes() |> Enum.map(&get_relative_strength_b/1)
      {strength, relative_strength}
    end)
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.reduce(0, fn {{_, _, bid}, index}, acc ->
      acc + bid * (index + 1)
    end)
  end
end
