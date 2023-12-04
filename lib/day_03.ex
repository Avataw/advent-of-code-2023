defmodule Day03 do
  def not_number_or_dot?(str) do
    cond do
      str not in ~w(0 1 2 3 4 5 6 7 8 9 .) -> true
      true -> false
    end
  end

  def solve_a(input) do
    map =
      input
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, acc ->
        String.graphemes(line)
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, x}, acc2 ->
          Map.put(acc2, Position.new([x, y]), char)
        end)
      end)

    numbers =
      Map.keys(map)
      |> Enum.sort_by(fn %Position{x: x, y: y} -> {y, x} end)
      |> Enum.reduce(%{result: %{}, current: "", positions: []}, fn pos, acc ->
        val = Map.get(map, pos)

        case val do
          val when val in ~w(0 1 2 3 4 5 6 7 8 9) ->
            %{result: acc.result, current: acc.current <> val, positions: [pos | acc.positions]}

          _ ->
            case acc.current do
              "" ->
                acc

              _ ->
                {int, _} = Integer.parse(acc.current)

                %{
                  result: Map.put(acc.result, acc.positions, int),
                  current: "",
                  positions: []
                }
            end
        end
      end)

    Map.filter(numbers.result, fn {positions, _} ->
      Enum.any?(positions, fn pos ->
        around = Position.around(pos)

        around
        |> Enum.any?(fn p ->
          val = Map.get(map, p, ".")
          not_number_or_dot?(val)
        end)
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def solve_b(input) do
    map =
      input
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, y}, acc ->
        String.graphemes(line)
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {char, x}, acc2 ->
          Map.put(acc2, Position.new([x, y]), char)
        end)
      end)

    numbers =
      Map.keys(map)
      |> Enum.sort_by(fn %Position{x: x, y: y} -> {y, x} end)
      |> Enum.reduce(%{result: %{}, current: "", positions: []}, fn pos, acc ->
        val = Map.get(map, pos)

        case val do
          val when val in ~w(0 1 2 3 4 5 6 7 8 9) ->
            %{result: acc.result, current: acc.current <> val, positions: [pos | acc.positions]}

          _ ->
            case acc.current do
              "" ->
                acc

              _ ->
                {int, _} = Integer.parse(acc.current)

                %{
                  result: Map.put(acc.result, acc.positions, int),
                  current: "",
                  positions: []
                }
            end
        end
      end)

    Map.filter(map, fn {_, value} ->
      not_number_or_dot?(value)
    end)
    |> Map.keys()
    |> Enum.reduce([], fn pos, acc ->
      adjacentNumbers =
        Map.keys(numbers.result)
        |> Enum.filter(fn positions ->
          Position.around(pos)
          |> Enum.any?(fn sPos ->
            Enum.any?(positions, fn nPos ->
              sPos.x == nPos.x && sPos.y == nPos.y
            end)
          end)
        end)
        |> Enum.map(fn adjacentNumberPos ->
          Map.get(numbers.result, adjacentNumberPos)
        end)

      case length(adjacentNumbers) do
        2 -> [adjacentNumbers | acc]
        _ -> acc
      end
    end)
    |> Enum.map(fn [a, b] -> a * b end)
    |> Enum.sum()
  end
end
