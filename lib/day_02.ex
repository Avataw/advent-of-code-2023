defmodule Day02 do
  def solve_a(input) do
    input
    |> Enum.map(fn line ->
      {id, _} = ParseHelper.get_inbetween(line, "Game ", ":") |> Integer.parse()

      valid =
        line
        |> ParseHelper.get_after(": ")
        |> String.split(";")
        |> Enum.all?(fn set ->
          set
          |> String.trim()
          |> String.split(", ")
          |> Enum.map(fn cubes -> String.split(cubes, " ") end)
          |> Enum.all?(fn [occurence, color] ->
            {occurence, _} = Integer.parse(occurence)

            case color do
              "red" -> occurence <= 12
              "green" -> occurence <= 13
              "blue" -> occurence <= 14
            end
          end)
        end)

      if valid do
        id
      else
        0
      end
    end)
    |> Enum.sum()
  end

  def solve_b(input) do
    input
    |> Enum.map(fn line ->
      line
      |> ParseHelper.get_after(": ")
      |> String.split([", ", "; "])
      |> Enum.map(fn cube -> String.split(cube, " ") end)
      |> Enum.reduce(%{}, fn [occ, color], acc ->
        {occurence, _} = Integer.parse(occ)

        current_max = Map.get(acc, color, 0)

        if occurence > current_max do
          Map.update(acc, color, occurence, fn _ -> occurence end)
        else
          acc
        end
      end)
      |> Map.values()
    end)
    |> Enum.map(fn [a, b, c] -> a * b * c end)
    |> Enum.sum()
  end
end
