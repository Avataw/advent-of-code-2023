defmodule Day09Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
      """
      |> StringHelper.to_lines()

    assert Day09.solve_a(input) == 114
  end

  test "solves a" do
    input = FileHelper.read_as_lines(9)
    assert Day09.solve_a(input) == 1_743_490_457
  end

  test "solves b example" do
    input =
      """
      0 3 6 9 12 15
      1 3 6 10 15 21
      10 13 16 21 30 45
      """
      |> StringHelper.to_lines()

    assert Day09.solve_b(input) == 2
  end

  test "solves b" do
    input = FileHelper.read_as_lines(9)
    assert Day09.solve_b(input) == 1053
  end
end
