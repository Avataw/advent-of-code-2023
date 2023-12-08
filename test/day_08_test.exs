defmodule Day08Test do
  use ExUnit.Case, async: true

  test "solves a" do
    input = FileHelper.read_as_lines(8)
    assert Day08.solve_a(input) == 22357
  end

  test "solves b" do
    input = FileHelper.read_as_lines(8)
    assert Day08.solve_b(input) == 10_371_555_451_871
  end
end
