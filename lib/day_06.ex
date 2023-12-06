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

  def solve_a(input) do
    parse(input)
    |> Enum.map(fn {time, max_distance} ->
      0..time
      |> Enum.map(fn speed ->
        time_left = time - speed

        speed * time_left
      end)
      |> Enum.count(fn distance -> distance > max_distance end)
    end)
    |> Enum.product()
  end

  def parse_b(input) do
    [time, distance] =
      input
      |> IO.inspect()
      |> Enum.map(fn line ->
        number =
          line
          |> String.replace(" ", "")
          |> ParseHelper.get_after(":")

        {result, _} = Integer.parse(number)
        result
      end)
      |> IO.inspect()

    [{time, distance}]
  end

  def solve_b(input) do
    parse_b(input)
    |> Enum.map(fn {time, max_distance} ->
      0..time
      |> Enum.map(fn speed ->
        time_left = time - speed

        speed * time_left
      end)
      |> Enum.count(fn distance -> distance > max_distance end)
    end)
    |> Enum.product()
  end
end
