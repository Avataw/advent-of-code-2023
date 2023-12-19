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

  # sooo slow, took over 15 minutes damn
  @tag timeout: :infinity
  @tag :skip
  test "solves a" do
    input = FileHelper.read_as_lines(17)
    assert Day17.solve_a(input) == 1238
  end

  @tag :skip

  test "solves b example" do
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

    assert Day17.solve_b(input) == 94
  end

  # this takes almost :infinity time... took over 30 mins for me
  @tag timeout: :infinity
  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(17)
    assert Day17.solve_b(input) == 1362
  end
end
