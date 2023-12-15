defmodule Day15Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
      """
      |> StringHelper.to_lines()

    assert Day15.solve_a(input) == 1320
  end

  test "solves a" do
    input = FileHelper.read_as_lines(15)
    assert Day15.solve_a(input) == 519_603
  end

  test "solves b example" do
    input =
      """
      rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
      """
      |> StringHelper.to_lines()

    assert Day15.solve_b(input) == 145
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(15)
    assert Day15.solve_b(input) == 593_821_230_983
  end
end
