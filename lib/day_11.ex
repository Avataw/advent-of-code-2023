defmodule Day11 do
  def construct_grid(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, x}, acc2 ->
        acc2 |> Map.put(Position.new([x, y]), char)
      end)
    end)
  end

  def get_expanding_space(galaxies, size) do
    expanding_rows =
      0..(size - 1)
      |> Enum.filter(fn y ->
        galaxies |> Enum.all?(fn galaxy -> galaxy.y != y end)
      end)

    expanding_cols =
      0..(size - 1)
      |> Enum.filter(fn x ->
        galaxies |> Enum.all?(fn galaxy -> galaxy.x != x end)
      end)

    {expanding_rows, expanding_cols}
  end

  def get_distance(pos1, pos2, expanding_rows, expanding_cols, factor \\ 2) do
    manhattan_distance = Position.manhattan_distance_to(pos1, pos2)

    expanding_x =
      pos1.x..pos2.x |> Enum.filter(fn x -> expanding_cols |> Enum.member?(x) end) |> length()

    expanding_y =
      pos1.y..pos2.y |> Enum.filter(fn y -> expanding_rows |> Enum.member?(y) end) |> length()

    expanding_x = expanding_x * (factor - 1)
    expanding_y = expanding_y * (factor - 1)

    manhattan_distance + expanding_x + expanding_y
  end

  def solve_a(input) do
    grid = input |> construct_grid

    galaxies = grid |> Map.filter(fn {_, value} -> value == "#" end) |> Map.keys()

    {expanding_rows, expanding_cols} = get_expanding_space(galaxies, length(input) - 1)

    galaxies = galaxies |> Enum.with_index()

    galaxies
    |> Enum.reduce(%{}, fn {galaxy, id}, acc ->
      galaxies
      |> Enum.reject(fn {_, other_id} -> other_id == id end)
      |> Enum.reduce(acc, fn {other_galaxy, other_id}, acc2 ->
        key = [id, other_id] |> Enum.sort()

        previous_distance = acc2 |> Map.get(key)
        current_distance = get_distance(galaxy, other_galaxy, expanding_rows, expanding_cols)

        case previous_distance do
          nil ->
            Map.put(acc2, key, current_distance)

          _ ->
            lowest_distance = [previous_distance, current_distance] |> Enum.sort() |> hd()
            Map.update!(acc2, key, fn _ -> lowest_distance end)
        end
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def solve_b(input, factor) do
    grid = input |> construct_grid

    galaxies = grid |> Map.filter(fn {_, value} -> value == "#" end) |> Map.keys()

    {expanding_rows, expanding_cols} = get_expanding_space(galaxies, length(input) - 1)

    galaxies = galaxies |> Enum.with_index()

    galaxies
    |> Enum.reduce(%{}, fn {galaxy, id}, acc ->
      galaxies
      |> Enum.reject(fn {_, other_id} -> other_id == id end)
      |> Enum.reduce(acc, fn {other_galaxy, other_id}, acc2 ->
        key = [id, other_id] |> Enum.sort()

        previous_distance = acc2 |> Map.get(key)

        current_distance =
          get_distance(galaxy, other_galaxy, expanding_rows, expanding_cols, factor)

        case previous_distance do
          nil ->
            Map.put(acc2, key, current_distance)

          _ ->
            lowest_distance = [previous_distance, current_distance] |> Enum.sort() |> hd()
            Map.update!(acc2, key, fn _ -> lowest_distance end)
        end
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
