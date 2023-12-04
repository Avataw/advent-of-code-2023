defmodule Day04Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      """
      |> StringHelper.to_lines()

    assert Day04.solve_a(input) == 13
  end

  # 441840 too low
  test "solves a" do
    input = FileHelper.read_as_lines(4)
    assert Day04.solve_a(input) == 24706
  end

  test "solves b example" do
    input =
      """
      Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      """
      |> StringHelper.to_lines()

    assert Day04.solve_b(input) == 30
  end

  test "solves b" do
    input = FileHelper.read_as_lines(4)
    assert Day04.solve_b(input) == 13_114_317
  end
end
