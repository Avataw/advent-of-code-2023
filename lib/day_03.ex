defmodule Day03 do
  def is_digit?(str) do
    cond do
      str in ~w(0 1 2 3 4 5 6 7 8 9) -> true
      true -> false
    end
  end

  def not_number_or_dot?(str) do
    cond do
      str not in ~w(0 1 2 3 4 5 6 7 8 9 .) -> true
      true -> false
    end
  end

  def construct_grid(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      String.graphemes(line)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, x}, acc2 ->
        Map.put(acc2, Position.new([x, y]), char)
      end)
    end)
  end

  def track_number_part(position, numbers, digit) do
    %{
      result: numbers.result,
      current: numbers.current <> digit,
      positions: [position | numbers.positions]
    }
  end

  def track_full_number(numbers) when numbers.current == "" do
    numbers
  end

  def track_full_number(numbers) do
    {full_number, _} = Integer.parse(numbers.current)

    %{
      result: Map.put(numbers.result, numbers.positions, full_number),
      current: "",
      positions: []
    }
  end

  def get_numbers(grid) do
    grid
    |> Map.keys()
    |> Enum.sort_by(fn %Position{x: x, y: y} -> {y, x} end)
    |> Enum.reduce(%{result: %{}, current: "", positions: []}, fn position, numbers ->
      char = Map.get(grid, position)

      if is_digit?(char),
        do: track_number_part(position, numbers, char),
        else: track_full_number(numbers)
    end)
  end

  def find_numbers_with_adjacent_symbol(grid, numbers) do
    Map.filter(numbers, fn {positions, _} ->
      Enum.any?(positions, fn pos ->
        Position.around(pos)
        |> Enum.any?(fn p ->
          val = Map.get(grid, p, ".")
          not_number_or_dot?(val)
        end)
      end)
    end)
    |> Map.values()
  end

  def solve_a(input) do
    grid = construct_grid(input)
    numbers = get_numbers(grid)

    find_numbers_with_adjacent_symbol(grid, numbers.result)
    |> Enum.sum()
  end

  def find_adjacent_numbers(numbers, symbol_position) do
    positions_around_symbol = Position.around(symbol_position)
    number_positions = Map.keys(numbers.result)

    number_positions
    |> Enum.filter(fn positions ->
      positions_around_symbol
      |> Enum.any?(fn sPos ->
        Enum.any?(positions, fn nPos ->
          Position.equals?(sPos, nPos)
        end)
      end)
    end)
    |> Enum.map(fn adjacentNumberPos ->
      Map.get(numbers.result, adjacentNumberPos)
    end)
  end

  def get_symbol_positions(grid) do
    Map.filter(grid, fn {_, value} ->
      not_number_or_dot?(value)
    end)
    |> Map.keys()
  end

  def solve_b(input) do
    grid = construct_grid(input)
    numbers = get_numbers(grid)

    get_symbol_positions(grid)
    |> Enum.reduce(0, fn symbol_position, acc ->
      adjacentNumbers = find_adjacent_numbers(numbers, symbol_position)

      cond do
        length(adjacentNumbers) == 2 -> acc + Enum.product(adjacentNumbers)
        true -> acc
      end
    end)
  end
end
