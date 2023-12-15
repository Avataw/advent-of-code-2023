defmodule Day14Test do
  use ExUnit.Case, async: true

  test "solves a example" do
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

    assert Day14.solve_a(input) == 136
  end

  test "solves a" do
    input = FileHelper.read_as_lines(14)
    assert Day14.solve_a(input) == 105_461
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

    assert Day14.solve_b(input) == 64
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(14)
    assert Day14.solve_b(input) == 102_829
  end
end
