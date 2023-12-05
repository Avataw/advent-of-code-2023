defmodule Day05Test do
  use ExUnit.Case, async: true

  test "solves a" do
    input = FileHelper.read_as_lines(5)
    assert Day05.solve_a(input) == 379_811_651
  end

  test "solves b" do
    input = FileHelper.read_as_lines(5)
    assert Day05.solve_b(input) == 27992443
  end
end
