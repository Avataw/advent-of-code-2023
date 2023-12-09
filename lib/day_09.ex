defmodule Day09 do
  def solve_a(input) do
    input
    |> parse
    |> Enum.map(&get_projection/1)
    |> Enum.sum()
  end

  def solve_b(input) do
    input
    |> parse
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&get_projection/1)
    |> Enum.sum()
  end

  def parse(input) do
    input
    |> Enum.map(fn line ->
      line |> String.split(" ") |> Enum.map(&ParseHelper.get_number/1)
    end)
  end

  def get_projection(history) do
    history
    |> solve()
    |> EnumHelper.last()
  end

  def solve(history) do
    done = history |> Enum.frequencies() |> map_size() == 1

    case done do
      true -> history
      false -> add_projection(history)
    end
  end

  def add_projection(history) do
    result = get_intervals(history) |> solve() |> EnumHelper.last()
    last = history |> EnumHelper.last()

    EnumHelper.push(history, last + result)
  end

  def get_intervals(history) do
    {intervals, _} =
      history
      |> Enum.drop(1)
      |> Enum.reduce({[], history |> hd}, fn cur, acc ->
        {list, last} = acc

        list = list |> EnumHelper.push(cur - last)
        {list, cur}
      end)

    intervals
  end
end
