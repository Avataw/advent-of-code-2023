defmodule Day13Test do
  use ExUnit.Case, async: true

  @tag :skip
  test "final" do
    input =
      """
      #.##..##.
      ..#.##.#.
      ##..#...#
      ##...#..#
      ..#.##.#.
      ..##..##.
      #.#.##.#.
      """

    assert Day13.solve_a(input) == 709
  end

  @tag :skip
  test "test" do
    input =
      """
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.

      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#

      .#.##.#.#
      .##..##..
      .#.##.#..
      #......##
      #......##
      .#.##.#..
      .##..##.#

      #..#....#
      ###..##..
      .##.#####
      .##.#####
      ###..##..
      #..#....#
      #..##...#

      #.##..##.
      ..#.##.#.
      ##..#...#
      ##...#..#
      ..#.##.#.
      ..##..##.
      #.#.##.#.
      """

    assert Day13.solve_a(input) == 709
  end

  @tag :skip
  test "solves a example" do
    input =
      """
      #.##..##.
      ..#.##.#.
      ##......#
      ##......#
      ..#.##.#.
      ..##..##.
      #.#.##.#.

      #...##..#
      #....#..#
      ..##..###
      #####.##.
      #####.##.
      ..##..###
      #....#..#
      """

    assert Day13.solve_a(input) == 405
  end

  test "solves a" do
    input =
      FileHelper.read_file(13)
      |> Enum.join("")

    assert Day13.solve_a(input) == 33195
  end

  @tag :skip
  test "solves b example" do
    input =
      """
      O....#....
      O.OO#....#
      .....##...
      OO.#O....O
      .O.....O#.
      O.#..O.#.#
      ..O..#O..O
      .......O..
      #....###..
      #OO..#....
      """
      |> StringHelper.to_lines()

    assert Day13.solve_b(input) == 64
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(13)
    assert Day13.solve_b(input) == 102_829
  end
end
