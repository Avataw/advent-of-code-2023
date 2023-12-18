defmodule Day18Test do
  use ExUnit.Case, async: true

  @tag :skip
  test "solves a example" do
    input =
      """
      R 6 (#70c710)
      D 5 (#0dc571)
      L 2 (#5713f0)
      D 2 (#d2c081)
      R 2 (#59c680)
      D 2 (#411b91)
      L 5 (#8ceee2)
      U 2 (#caa173)
      L 1 (#1b58a2)
      U 2 (#caa171)
      R 2 (#7807d2)
      U 3 (#a77fa3)
      L 2 (#015232)
      U 2 (#7a21e3)
      """
      |> StringHelper.to_lines()

    assert Day18.solve_a(input) == 62
  end

  @tag :skip
  test "solves a" do
    input = FileHelper.read_as_lines(18)
    assert Day18.solve_a(input) == 34329
  end

  test "solves b example" do
    input =
      """
      R 6 (#70c710)
      D 5 (#0dc571)
      L 2 (#5713f0)
      D 2 (#d2c081)
      R 2 (#59c680)
      D 2 (#411b91)
      L 5 (#8ceee2)
      U 2 (#caa173)
      L 1 (#1b58a2)
      U 2 (#caa171)
      R 2 (#7807d2)
      U 3 (#a77fa3)
      L 2 (#015232)
      U 2 (#7a21e3)
      """
      |> StringHelper.to_lines()

    assert Day18.solve_b(input) == 952_408_144_115
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(18)
    assert Day18.solve_b(input) == 8023
  end
end
