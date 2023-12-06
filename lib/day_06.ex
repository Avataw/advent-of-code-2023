defmodule Day06 do
  def parse(input) do
    [times, distances] =
      input
      |> Enum.map(fn line ->
        Regex.scan(~r/\d+/, line)
        |> List.flatten()
        |> Enum.map(fn number ->
          {result, _} = Integer.parse(number)
          result
        end)
      end)

    Enum.zip(times, distances)
  end

  def count_wins(time_and_distances) do
    time_and_distances
    |> Enum.map(fn {time, max_distance} ->
      0..time
      |> Enum.map(fn speed ->
        time_left = time - speed

        speed * time_left
      end)
      |> Enum.count(fn distance -> distance > max_distance end)
    end)
  end

  def solve_a(input) do
    parse(input)
    |> count_wins()
    |> Enum.product()
  end

  def solve_b(input) do
    input
    |> Enum.map(fn line -> String.replace(line, " ", "") end)
    |> parse()
    |> count_wins()
    |> Enum.product()
  end
end
