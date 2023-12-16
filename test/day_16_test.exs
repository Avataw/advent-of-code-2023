defmodule Day16Test do
  use ExUnit.Case, async: true

  @tag :skip
  test "solves a example" do
    input =
      """
      .|...(....
      |.-.(.....
      .....|-...
      ........|.
      ..........
      .........(
      ..../.((..
      .-.-/..|..
      .|....-|.(
      ..//.|....
      """
      |> StringHelper.to_lines()

    assert Day16.solve_a(input) == 46
  end

  @tag :skip
  test "solves a" do
    input = FileHelper.read_as_lines(16)
    assert Day16.solve_a(input) == 7632
  end

  @tag :skip
  test "solves b example" do
    input =
      """
      .|...(....
      |.-.(.....
      .....|-...
      ........|.
      ..........
      .........(
      ..../.((..
      .-.-/..|..
      .|....-|.(
      ..//.|....
      """
      |> StringHelper.to_lines()

    assert Day16.solve_b(input) == 51
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(16)
    assert Day16.solve_b(input) == 8023
  end
end
