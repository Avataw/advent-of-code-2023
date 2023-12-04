defmodule Day04 do
  def calc_winning_cards(input) do
    input
    |> Enum.map(fn line ->
      winning = ParseHelper.get_inbetween(line, ": ", " |") |> String.split(" ")

      ParseHelper.get_after(line, "| ")
      |> String.split(" ")
      |> Enum.reject(fn s -> s == "" end)
      |> Enum.count(fn number ->
        Enum.member?(winning, number)
      end)
    end)
  end

  def calc_score(winning_cards) do
    winning_cards
    |> Enum.reduce(0, fn wins, score ->
      case wins do
        0 -> score
        _ -> score + 2 ** (wins - 1)
      end
    end)
  end

  def track_instances(index, wins, instance_count, instances) do
    (index + 1)..(index + wins)
    |> Enum.reduce(instances, fn ind, acc ->
      Map.update(acc, ind, instance_count, fn current_count ->
        current_count + instance_count
      end)
    end)
  end

  def count_instances(winning_cards) do
    winning_cards
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {wins, index}, instances ->
      instance_count = Map.get(instances, index, 0) + 1

      updated_instances = Map.put(instances, index, instance_count)

      cond do
        wins == 0 -> updated_instances
        true -> track_instances(index, wins, instance_count, updated_instances)
      end
    end)
  end

  def solve_a(input) do
    input
    |> calc_winning_cards()
    |> calc_score()
  end

  def solve_b(input) do
    input
    |> calc_winning_cards()
    |> count_instances()
    |> Map.values()
    |> Enum.sum()
  end
end
