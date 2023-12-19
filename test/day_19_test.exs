defmodule Day19Test do
  use ExUnit.Case, async: true

  test "solves a example" do
    input =
      """
      px{a<2006:qkq,m>2090:A,rfg}
      pv{a>1716:R,A}
      lnx{m>1548:A,A}
      rfg{s<537:gd,x>2440:R,A}
      qs{s>3448:A,lnx}
      qkq{x<1416:A,crn}
      crn{x>2662:A,R}
      in{s<1351:px,qqz}
      qqz{s>2770:qs,m<1801:hdj,R}
      gd{a>3333:R,R}
      hdj{m>838:A,pv}

      {x=787,m=2655,a=1222,s=2876}
      {x=1679,m=44,a=2067,s=496}
      {x=2036,m=264,a=79,s=2244}
      {x=2461,m=1339,a=466,s=291}
      {x=2127,m=1623,a=2188,s=1013}
      """
      |> StringHelper.to_lines()

    assert Day19.solve_a(input) == 19114
  end

  test "solves a" do
    input = FileHelper.read_as_lines(19)
    assert Day19.solve_a(input) == 425_811
  end

  @tag :skip
  test "solves b example" do
    input =
      """
      R 6 (#70c710)
      D 5 (#0dc571)
      L 2 (#5713f0)
      D 2 (#d2c081)
      R 2 (#59c680)
      D 2 (#411b91)
      L 5 (#8ceee2)
      U 2 (#caa173)
      L 1 (#1b58a2)
      U 2 (#caa171)
      R 2 (#7807d2)
      U 3 (#a77fa3)
      L 2 (#015232)
      U 2 (#7a21e3)
      """
      |> StringHelper.to_lines()

    assert Day19.solve_b(input) == 952_408_144_115
  end

  @tag :skip
  test "solves b" do
    input = FileHelper.read_as_lines(19)
    assert Day19.solve_b(input) == 42_617_947_302_920
  end
end
