defmodule Day11Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
      """
      |> StringHelper.to_lines()

    assert Day11.solve_a(input) == 374
  end

  test "solves a" do
    input = FileHelper.read_as_lines(11)
    assert Day11.solve_a(input) == 9_418_609
  end

  test "solves b example" do
    input =
      """
      ...#......
      .......#..
      #.........
      ..........
      ......#...
      .#........
      .........#
      ..........
      .......#..
      #...#.....
      """
      |> StringHelper.to_lines()

    assert Day11.solve_b(input, 10) == 1030
  end

  test "solves b" do
    input = FileHelper.read_as_lines(11)
    assert Day11.solve_b(input, 1_000_000) == 593_821_230_983
  end
end
