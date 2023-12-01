defmodule Day01Test do
  use ExUnit.Case, async: true

  test "solves a" do
    assert Day01.solve_a() == 55108
  end

  test "solves b" do
    assert Day01.solve_b() == 56324
  end
end
