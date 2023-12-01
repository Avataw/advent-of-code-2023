defmodule Day01Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      1abc2
      pqr3stu8vwx
      a1b2c3d4e5f
      treb7uchet
      """
      |> StringHelper.to_lines()

    assert Day01.solve_a(input) == 142
  end

  test "solves a" do
    input = FileHelper.read_as_lines(1)
    assert Day01.solve_a(input) == 55108
  end

  test "solves b example" do
    input =
      """
      two1nine
      eightwothree
      abcone2threexyz
      xtwone3four
      4nineeightseven2
      zoneight234
      7pqrstsixteen
      """
      |> StringHelper.to_lines()

    assert Day01.solve_b(input) == 281
  end

  test "solves b" do
    input = FileHelper.read_as_lines(1)
    assert Day01.solve_b(input) == 56324
  end
end
