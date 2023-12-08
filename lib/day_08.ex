defmodule Day08 do
  def get_directions(input) do
    input
    |> Enum.drop(2)
    |> Map.new(fn line ->
      position = ParseHelper.get_before(line, " =")

      left = ParseHelper.get_inbetween(line, "(", ",")
      right = ParseHelper.get_inbetween(line, ", ", ")")

      {position, {left, right}}
    end)
  end

  def traverse({left, right}, instruction, steps) do
    case instruction do
      "L" -> {:cont, {steps + 1, left}}
      "R" -> {:cont, {steps + 1, right}}
    end
  end

  def solve_a(input) do
    instructions = hd(input) |> String.graphemes()

    directions = get_directions(input)

    instructions
    |> Stream.cycle()
    |> Enum.reduce_while({0, "AAA"}, fn instruction, acc ->
      {steps, position} = acc

      case position do
        "ZZZ" -> {:halt, steps}
        _ -> Map.get(directions, position) |> traverse(instruction, steps)
      end
    end)
  end

  def solve_b(input) do
    instructions = hd(input) |> String.graphemes()

    directions = get_directions(input)

    positions =
      directions
      |> Map.keys()
      |> Enum.filter(fn key -> String.ends_with?(key, "A") end)

    positions
    |> Enum.map(fn position ->
      instructions
      |> Stream.cycle()
      |> Enum.reduce_while({0, position, []}, fn instruction, acc ->
        {steps, position, targets} = acc

        targets =
          cond do
            position |> String.ends_with?("Z") -> [steps | targets]
            true -> targets
          end

        if length(targets) == 2 do
          [second, first] = targets
          {:halt, second - first}
        else
          {left, right} = Map.get(directions, position)

          case instruction do
            "L" -> {:cont, {steps + 1, left, targets}}
            "R" -> {:cont, {steps + 1, right, targets}}
          end
        end
      end)
    end)
    |> Enum.reduce(&MathHelper.lcd/2)
  end
end
