defmodule Day14 do
  def construct_grid(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, x}, acc2 ->
        Map.put(acc2, Position.new([x, y]), char)
      end)
    end)
  end

  def traverse_up(grid, pos) do
    up = Map.get(grid, Position.up(pos))

    case up do
      "." -> traverse_up(grid, Position.up(pos))
      _ -> pos
    end
  end

  def solve_a(input) do
    grid =
      input
      |> construct_grid()

    length = length(input)

    grid
    |> Enum.sort_by(fn {%Position{x: x, y: y}, _} -> {y, x} end)
    |> Enum.reduce(grid, fn {pos, char}, acc ->
      case char do
        "O" ->
          move_up = traverse_up(acc, pos)

          acc
          |> Map.update!(pos, fn _ -> "." end)
          |> Map.update!(move_up, fn _ -> "O" end)

        _ ->
          acc
      end
    end)
    |> Enum.map(fn {pos, char} ->
      case char do
        "O" -> length - pos.y
        _ -> 0
      end
    end)
    |> Enum.sum()
  end

  def solve_b(input) do
    1
  end
end
