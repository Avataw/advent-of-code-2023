defmodule Day02Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """
      |> StringHelper.to_lines()

    assert Day02.solve_a(input) == 8
  end

  test "solves a" do
    input = FileHelper.read_as_lines(2)
    assert Day02.solve_a(input) == 2105
  end

  test "solves b example" do
    input =
      """
      Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
      Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
      Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
      Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
      Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
      """
      |> StringHelper.to_lines()

    assert Day02.solve_b(input) == 2286
  end

  test "solves b" do
    input = FileHelper.read_as_lines(2)
    assert Day02.solve_b(input) == 72422
  end
end
