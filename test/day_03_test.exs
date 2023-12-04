defmodule Day03Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """
      |> StringHelper.to_lines()

    assert Day03.solve_a(input) == 4361
  end

  # 441840 too low
  test "solves a" do
    input = FileHelper.read_as_lines(3)
    assert Day03.solve_a(input) == 530_495
  end

  test "solves b example" do
    input =
      """
      467..114..
      ...*......
      ..35..633.
      ......#...
      617*......
      .....+.58.
      ..592.....
      ......755.
      ...$.*....
      .664.598..
      """
      |> StringHelper.to_lines()

    assert Day03.solve_b(input) == 467_835
  end

  test "solves b" do
    input = FileHelper.read_as_lines(3)
    assert Day03.solve_b(input) == 1
  end
end
