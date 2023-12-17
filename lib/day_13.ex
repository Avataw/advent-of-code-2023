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

  def get_mountain_permutations(mountain) do
    line_length = mountain |> hd() |> String.length()

    input = mountain |> Enum.join()

    input
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {char, index} ->
      new_char =
        case char do
          "." -> "#"
          "#" -> "."
        end

      StringHelper.replace_at(input, index, new_char)
      |> String.graphemes()
      |> Enum.chunk_every(line_length)
      |> Enum.map(&Enum.join/1)
    end)
  end

  def solve_b(input) do
    input
    |> parse
    |> Enum.map(fn mountain ->
      vertical_result = find_vertical_mirror(mountain)
      horizontal_result = find_horizontal_mirror(mountain)

      mountain
      |> get_mountain_permutations()
      |> Enum.map(fn perm ->
        vertical =
          find_vertical_mirror(perm)
          |> Enum.reject(fn v -> vertical_result |> Enum.member?(v) end)
          |> Enum.sum()

        horizontal =
          find_horizontal_mirror(perm)
          |> Enum.reject(fn h -> horizontal_result |> Enum.member?(h) end)
          |> Enum.map(fn h -> h * 100 end)
          |> Enum.sum()

        case {vertical, horizontal} do
          {0, 0} -> nil
          {v, h} -> v + h
        end
      end)
      |> Enum.reject(fn r -> r == nil end)
      |> hd()
    end)
    |> Enum.sum()
  end
end
