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

  def traverse_right(grid, pos) do
    right = Map.get(grid, Position.right(pos))

    case right do
      "." -> traverse_right(grid, Position.right(pos))
      _ -> pos
    end
  end

  def traverse_down(grid, pos) do
    down = Map.get(grid, Position.down(pos))

    case down do
      "." -> traverse_down(grid, Position.down(pos))
      _ -> pos
    end
  end

  def traverse_left(grid, pos) do
    left = Map.get(grid, Position.left(pos))

    case left do
      "." -> traverse_left(grid, Position.left(pos))
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

  def print(input) do
    input
    |> Enum.map(fn {_, char} -> char end)
    |> Enum.chunk_every(10)
    |> Enum.map(&Enum.join/1)
    |> Enum.each(&IO.puts/1)

    input
  end

  def solve_b(input) do
    grid = construct_grid(input)

    length = length(input)

    {_, final_results} =
      [:up, :left, :down, :right]
      |> Stream.cycle()
      |> Enum.take(1000)
      |> Enum.reduce({grid, []}, fn instruction, {acc, results} ->
        next_grid =
          acc
          |> Enum.filter(fn {_, char} -> char == "O" end)
          |> Enum.sort_by(fn {%Position{x: x, y: y}, _} ->
            case instruction do
              :up -> {y, x}
              :left -> {y, x}
              :right -> {y, -x}
              :down -> {-y, x}
            end
          end)
          |> Enum.reduce(acc, fn {pos, char}, acc2 ->
            case char do
              "O" ->
                next =
                  case instruction do
                    :up -> traverse_up(acc2, pos)
                    :left -> traverse_left(acc2, pos)
                    :right -> traverse_right(acc2, pos)
                    :down -> traverse_down(acc2, pos)
                  end

                acc2
                |> Map.update!(pos, fn _ -> "." end)
                |> Map.update!(next, fn _ -> "O" end)

              _ ->
                acc2
            end
          end)

        result =
          next_grid
          |> Enum.map(fn {pos, char} ->
            case char do
              "O" -> length - pos.y
              _ -> 0
            end
          end)
          |> Enum.sum()

        {next_grid, [result | results]}
      end)

    final_results
    |> Enum.reverse()
    |> Enum.drop(3)
    |> Enum.take_every(4)
    |> Enum.with_index()

    # solved by manually looking for the cycle :D I was watching FACE OFF while solving this and understandably could not concentrate
    {result, _} =
      [102_831, 102_829, 102_827, 102_828, 102_837, 102_851, 102_834]
      |> Enum.with_index()
      |> Enum.map(fn {value, index} ->
        {value, index + 244}
      end)
      |> Stream.cycle()
      |> Enum.at(100_000_000 - 1)

    result
  end
end
