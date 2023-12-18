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
      |> Enum.reduce({[], start}, fn {direction, amount}, {acc, current_position} ->
        target_position =
          case direction do
            "U" -> Position.new([current_position.x, current_position.y - amount])
            "R" -> Position.new([current_position.x + amount, current_position.y])
            "D" -> Position.new([current_position.x, current_position.y + amount])
            "L" -> Position.new([current_position.x - amount, current_position.y])
          end

        {[{current_position, target_position} | acc], target_position}
      end)

    grid
  end

  def shoelace(positions) do
    area =
      positions
      |> Enum.map(fn {first_pos, second_pos} ->
        diff = abs(second_pos.x - first_pos.x) + abs(second_pos.y - first_pos.y)

        first_pos.x * second_pos.y - first_pos.y * second_pos.x + diff
      end)
      |> Enum.sum()

    area / 2 + 1
  end

  def solve_a(input) do
    input
    |> parse()
    |> construct_grid()
    |> shoelace()
  end

  def parse_b(input) do
    input
    |> Enum.map(fn line ->
      hex = line |> ParseHelper.get_inbetween("(#", ")")

      {amount, _} = hex |> String.slice(0..4) |> Integer.parse(16)
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
    input
    |> parse_b()
    |> construct_grid()
    |> shoelace()
  end
end
