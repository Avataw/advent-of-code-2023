defmodule Day13Test do
  use ExUnit.Case, async: true

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

  @tag :skip
  test "solves a" do
    input =
      FileHelper.read_file(13)
      |> Enum.join("")

    assert Day13.solve_a(input) == 33195
  end

  test "solves b example" do
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

    assert Day13.solve_b(input) == 400
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_file(13) |> Enum.join("")
    assert Day13.solve_b(input) == 31836
  end
end
