defmodule Day17Test do
  use ExUnit.Case, async: true

  @tag :skip

  test "solves a example" do
    input =
      """
      2413432311323
      3215453535623
      3255245654254
      3446585845452
      4546657867536
      1438598798454
      4457876987766
      3637877979653
      4654967986887
      4564679986453
      1224686865563
      2546548887735
      4322674655533
      """
      |> StringHelper.to_lines()

    assert Day17.solve_a(input) == 102
  end

  # 1277
  # 1273 too high
  # 1269 too high
  # 1249 too high
  # 1248 too high

  @tag timeout: :infinity
  @tag :skip
  test "solves a" do
    input = FileHelper.read_as_lines(17)
    assert Day17.solve_a(input) == 34329
  end

  @tag :skip
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

    assert Day17.solve_b(input) == 952_408_144_115
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(17)
    assert Day17.solve_b(input) == 42_617_947_302_920
  end
end
