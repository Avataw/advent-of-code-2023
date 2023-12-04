defmodule Day04 do
  def solve_a(input) do
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
    |> Enum.reject(fn count -> count == 0 end)
    |> Enum.map(fn count ->
      2 ** (count - 1)
    end)
    |> Enum.sum()
  end

  def solve_b(input) do
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
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {cur, index}, acc ->
      instances = Map.get(acc, index, 0) + 1

      if cur == 0 do
        Map.update(acc, index, instances, fn _ -> instances end)
      else
        (index + 1)..(index + cur)
        |> Enum.reduce(acc, fn i, acc2 ->
          Map.update(acc2, i, instances, fn i -> i + instances end)
          |> Map.update(index, instances, fn _ -> instances end)
        end)
      end
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
