defmodule Day07Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
      """
      |> StringHelper.to_lines()

    assert Day07.solve_a(input) == 6440
  end

  test "solves a" do
    input = FileHelper.read_as_lines(7)
    assert Day07.solve_a(input) == 251_806_792
  end

  test "solves b example" do
    input =
      """
      32T3K 765
      T55J5 684
      KK677 28
      KTJJT 220
      QQQJA 483
      """
      |> StringHelper.to_lines()

    assert Day07.solve_b(input) == 5905
  end

  test "solves b" do
    input = FileHelper.read_as_lines(7)
    assert Day07.solve_b(input) == 252_113_488
  end
end
