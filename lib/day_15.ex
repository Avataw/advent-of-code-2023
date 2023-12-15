defmodule Day15 do
  def calc_hash(string) do
    string
    |> String.to_charlist()
    |> Enum.reduce(0, fn ascii_value, acc ->
      ((acc + ascii_value) * 17) |> rem(256)
    end)
  end

  def solve_a(input) do
    input
    |> hd()
    |> String.split(",")
    |> Enum.map(&calc_hash/1)
    |> Enum.sum()
  end

  def solve_b(input) do
    1
  end
end
