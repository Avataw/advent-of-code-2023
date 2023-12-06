defmodule Day06Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      Time:      7  15   30
      Distance:  9  40  200
      """
      |> StringHelper.to_lines()

    assert Day06.solve_a(input) == 288
  end

  test "solves a" do
    input = FileHelper.read_as_lines(6)
    assert Day06.solve_a(input) == 1_624_896
  end

  test "solves b example" do
    input =
      """
      Time:      7  15   30
      Distance:  9  40  200
      """
      |> StringHelper.to_lines()

    assert Day06.solve_b(input) == 71503
  end

  test "solves b" do
    input = FileHelper.read_as_lines(6)
    assert Day06.solve_b(input) == 1
  end
end
