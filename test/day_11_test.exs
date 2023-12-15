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
    assert Day11.solve_a(input) == 1
  end

  @tag :skip
  test "solves b example" do
    input =
      """
      FF7FSF7F7F7F7F7F---7
      L|LJ||||||||||||F--J
      FL-7LJLJ||||||LJL-77
      F--JF--7||LJLJ7F7FJ-
      L---JF-JLJ.||-FJLJJ7
      |F|F-JF---7F7-L7L|7|
      |FFJF7L7F-JF7|JL---7
      7-L-JL7||F7|L7F-7F7|
      L.L7LFJ|||||FJL7||LJ
      L7JLJL-JLJLJL--JLJ.L
      """
      |> StringHelper.to_lines()

    assert Day11.solve_b(input) == 1
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(11)
    assert Day11.solve_b(input) == 1
  end
end
