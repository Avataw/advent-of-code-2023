defmodule Day18 do
  def parse(input) do
    input
    |> Enum.map(fn line ->
      [direction, amount] = line |> ParseHelper.get_before(" (") |> String.split(" ")

      amount = ParseHelper.get_number(amount)

      {direction, amount}
    end)
  end

  def construct_grid(parsed_input) do
    start = Position.new([0, 0])

    {grid, _} =
      parsed_input
      |> Enum.reduce({%{}, start}, fn {direction, amount}, {acc, current_position} ->
        target_position =
          case direction do
            "U" -> Position.new([current_position.x, current_position.y - amount])
            "R" -> Position.new([current_position.x + amount, current_position.y])
            "D" -> Position.new([current_position.x, current_position.y + amount])
            "L" -> Position.new([current_position.x - amount, current_position.y])
          end

        acc =
          cond do
            direction == "U" ->
              target_position.y..current_position.y
              |> Enum.reduce(acc, fn y, acc2 ->
                Map.put(acc2, Position.new([current_position.x, y]), 1)
              end)

            direction == "D" ->
              current_position.y..target_position.y
              |> Enum.reduce(acc, fn y, acc2 ->
                Map.put(acc2, Position.new([current_position.x, y]), 1)
              end)

            direction == "R" ->
              current_position.x..target_position.x
              |> Enum.reduce(acc, fn x, acc2 ->
                Map.put(acc2, Position.new([x, current_position.y]), 1)
              end)

            direction == "L" ->
              target_position.x..current_position.x
              |> Enum.reduce(acc, fn x, acc2 ->
                Map.put(acc2, Position.new([x, current_position.y]), 1)
              end)
          end

        {acc, target_position}
      end)

    grid
  end

  def is_contained_by_grid?(grid, position) do
    is_grid = Map.get(grid, position)

    case is_grid do
      nil ->
        up =
          Map.filter(grid, fn {key, _} ->
            key.y < position.y && key.x == position.x
          end)
          |> map_size() > 0

        down =
          Map.filter(grid, fn {key, _} ->
            key.y > position.y && key.x == position.x
          end)
          |> map_size() > 0

        left =
          Map.filter(grid, fn {key, _} ->
            key.y == position.y && key.x < position.x
          end)
          |> map_size() > 0

        right =
          Map.filter(grid, fn {key, _} ->
            key.y == position.y && key.x > position.x
          end)
          |> map_size() > 0

        [up, down, left, right] |> Enum.all?()

      _ ->
        false
    end
  end

  def flood_fill(grid, position) do
    is_inside = Map.get(grid, position)

    case is_inside do
      nil ->
        grid = Map.put(grid, position, 0)

        Position.around(position)
        |> Enum.reduce(grid, fn position, acc ->
          flood_fill(acc, position)
        end)

      _ ->
        grid
    end
  end

  def solve_a(input) do
    grid =
      input
      |> parse()
      |> construct_grid()

    start_flood_fill =
      Position.around(Position.new([0, 0]))
      |> Enum.filter(fn position ->
        is_contained_by_grid?(grid, position)
      end)
      |> hd()

    flood_fill(grid, start_flood_fill) |> map_size()
  end

  def parse_b(input) do
    input
    |> Enum.map(fn line ->
      hex = line |> ParseHelper.get_inbetween("(#", ")")

      {amount, _} = hex |> String.slice(0..4) |> IO.inspect() |> Integer.parse(16)
      last_digit = hex |> String.slice(5..5)

      direction =
        case last_digit do
          "0" -> "R"
          "1" -> "D"
          "2" -> "L"
          "3" -> "U"
        end

      {direction, amount}
    end)
  end

  def solve_b(input) do
    grid =
      input
      |> parse_b()
      |> construct_grid()

    start_flood_fill =
      Position.around(Position.new([0, 0]))
      |> Enum.filter(fn position ->
        is_contained_by_grid?(grid, position)
      end)
      |> hd()

    flood_fill(grid, start_flood_fill) |> map_size()
  end
end
