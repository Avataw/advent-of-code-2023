defmodule Day12Test do
  use ExUnit.Case, async: true

  @tag :skip
  test "solves a example" do
    input =
      """
      ?###???????? 3,2,1
      """
      |> StringHelper.to_lines()

    assert Day12.solve_a(input) == 10
  end

  # iz too slo
  @tag timeout: :infinity
  test "solves a" do
    input = FileHelper.read_as_lines(12)
    assert Day12.solve_a(input) == 7379
  end

  @tag timeout: :infinity
  @tag :skip
  test "solves b example" do
    input =
      """
      ?###???????? 3,2,1
      """
      |> StringHelper.to_lines()

    # ?###???????? 3,2,1

    assert Day12.solve_b(input) == 1
  end

  @tag timeout: :infinity
  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(12)
    assert Day12.solve_b(input) == 593_821_230_983
  end
end
