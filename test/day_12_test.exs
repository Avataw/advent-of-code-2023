defmodule Day12Test do
  use ExUnit.Case, async: true

  @tag :skip
  test "solves a example" do
    input =
      """
      ???.### 1,1,3
      .??..??...?##. 1,1,3
      ?#?#?#?#?#?#?#? 1,3,1,6
      ????.#...#... 4,1,1
      ????.######..#####. 1,6,5
      ?###???????? 3,2,1
      """
      |> StringHelper.to_lines()

    assert Day12.solve_a(input) == 21
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
      ???.### 1,1,3
      .??..??...?##. 1,1,3
      ?#?#?#?#?#?#?#? 1,3,1,6
      ????.#...#... 4,1,1
      ????.######..#####. 1,6,5
      ?###???????? 3,2,1
      """
      |> StringHelper.to_lines()

    assert Day12.solve_b(input) == 525_152
  end

  @tag timeout: :infinity
  # took 2 minutes lol
  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(12)
    assert Day12.solve_b(input) == 7_732_028_747_925
  end
end
