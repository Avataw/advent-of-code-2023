defmodule Day13 do
  def parse(input) do
    {mountains, _} =
      input
      |> String.split("\n")
      |> Enum.reduce({[], []}, fn line, {acc, cur} ->
        case line do
          "" -> {[cur |> Enum.reverse() | acc], []}
          _ -> {acc, [line | cur]}
        end
      end)

    mountains
  end

  def find_vertical_mirror(mountain) do
    target_length = length(mountain)

    mountain
    |> Enum.flat_map(fn line ->
      letters = line |> String.graphemes()

      1..(length(letters) - 1)
      |> Enum.filter(fn i ->
        first_half = letters |> Enum.take(i)
        second_half = letters |> Enum.drop(i)

        length = min(length(first_half), length(second_half))

        first_half = first_half |> Enum.reverse() |> Enum.take(length) |> Enum.reverse()
        second_half = second_half |> Enum.take(length) |> Enum.reverse()

        first_half == second_half
      end)
    end)
    |> Enum.frequencies()
    |> Enum.filter(fn {_, frequencies} -> frequencies == target_length end)
    |> Enum.map(fn {value, _} -> value end)
  end

  def find_horizontal_mirror(mountain) do
    target_length = length(mountain |> hd() |> String.graphemes())

    mountain =
      0..(target_length - 1)
      |> Enum.reduce([], fn i, acc ->
        line =
          mountain
          |> Enum.map(fn line ->
            line |> String.graphemes() |> Enum.at(i)
          end)

        [line | acc]
      end)
      |> Enum.reverse()
      |> Enum.map(fn l -> Enum.join(l) end)

    # |> IO.inspect()

    mountain |> find_vertical_mirror()
  end

  def solve_a(input) do
    input
    |> parse
    |> Enum.map(fn mountain ->
      vertical = find_vertical_mirror(mountain) |> Enum.sum()
      horizontal = find_horizontal_mirror(mountain) |> Enum.map(fn h -> h * 100 end) |> Enum.sum()

      vertical + horizontal
    end)
    |> Enum.sum()
  end

  def solve_b(input) do
    1
  end
end
