defmodule Day12 do
  use Memoize

  def parse(input) do
    input
    |> Enum.map(fn line ->
      line |> String.split(" ")
    end)
  end

  defmemo rec_solve([], [], 0) do
    1
  end

  defmemo rec_solve(line, [], hashes) do
    cond do
      hashes > 0 -> 0
      line |> Enum.all?(fn c -> c != "#" end) -> 1
      true -> 0
    end
  end

  defmemo rec_solve([], target, hashes) do
    cond do
      target |> length() == 1 and target |> hd() == hashes -> 1
      true -> 0
    end
  end

  defmemo rec_solve(line, target, hashes) do
    first_letter = line |> hd()
    current_target = target |> hd()

    line = line |> Enum.drop(1)

    case first_letter do
      "." ->
        cond do
          hashes == 0 ->
            rec_solve(line, target, 0)

          hashes == current_target ->
            rec_solve(line, target |> Enum.drop(1), 0)

          true ->
            0
        end

      "?" ->
        [
          rec_solve(["#" | line], target, hashes),
          rec_solve(["." | line], target, hashes)
        ]
        |> Enum.sum()

      "#" ->
        rec_solve(line, target, hashes + 1)
    end
  end

  def solve_a(input) do
    parse(input)
    |> Enum.map(fn [line, target] ->
      line = line |> String.graphemes()
      target = target |> String.split(",") |> Enum.map(&ParseHelper.get_number/1)

      rec_solve(line, target, 0)
    end)
    |> Enum.sum()
  end

  def solve_b(input) do
    parse(input)
    |> Enum.with_index()
    |> Enum.map(fn {[line, target], index} ->
      line =
        [line]
        |> Stream.cycle()
        |> Enum.take(5)
        |> Enum.join("?")
        |> String.graphemes()

      target =
        [target]
        |> Stream.cycle()
        |> Enum.take(5)
        |> Enum.join(",")
        |> String.split(",")
        |> Enum.map(&ParseHelper.get_number/1)

      rec_solve(line, target, 0) |> IO.inspect(label: "solution for #{index}")
    end)
    |> Enum.sum()
  end
end
