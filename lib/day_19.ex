defmodule Day19 do
  def parse_workflows(input) do
    input
    |> Enum.take_while(fn line ->
      line
      |> String.starts_with?("{") == false
    end)
    |> Enum.reduce(%{}, fn workflow, acc ->
      key = workflow |> ParseHelper.get_before("{")
      instructions = workflow |> ParseHelper.get_inbetween("{", "}") |> String.split(",")
      acc |> Map.put(key, instructions)
    end)
  end

  def parse_part_ratings(input, workflow_length) do
    input
    |> Enum.drop(workflow_length)
    |> Enum.map(fn part_rating ->
      part_rating
      |> ParseHelper.get_inbetween("{", "}")
      |> String.split(",")
      |> Enum.map(fn p -> p |> String.split("=") end)
      |> Enum.reduce(%{}, fn [key, value], acc ->
        acc |> Map.put(key, value |> ParseHelper.get_number())
      end)
    end)
  end

  def work(part_rating, workflows, worfklow_key, instruction_number) do
    case worfklow_key do
      "A" ->
        part_rating |> Map.values() |> Enum.sum()

      "R" ->
        0

      _ ->
        instruction = workflows |> Map.get(worfklow_key) |> Enum.at(instruction_number)

        cond do
          instruction |> String.contains?("<") ->
            part_key = instruction |> ParseHelper.get_before("<")

            value =
              instruction |> ParseHelper.get_inbetween("<", ":") |> ParseHelper.get_number()

            next_worfklow_key = instruction |> ParseHelper.get_after(":")

            part_value = part_rating |> Map.get(part_key)

            cond do
              part_value < value -> work(part_rating, workflows, next_worfklow_key, 0)
              true -> work(part_rating, workflows, worfklow_key, instruction_number + 1)
            end

          instruction |> String.contains?(">") ->
            part_key = instruction |> ParseHelper.get_before(">")

            value =
              instruction |> ParseHelper.get_inbetween(">", ":") |> ParseHelper.get_number()

            next_worfklow_key = instruction |> ParseHelper.get_after(":")

            part_value = part_rating |> Map.get(part_key)

            cond do
              part_value > value -> work(part_rating, workflows, next_worfklow_key, 0)
              true -> work(part_rating, workflows, worfklow_key, instruction_number + 1)
            end

          true ->
            next_worfklow_key = instruction
            work(part_rating, workflows, next_worfklow_key, 0)
        end
    end
  end

  def solve_a(input) do
    workflows = input |> parse_workflows()
    part_ratings = input |> parse_part_ratings(workflows |> map_size())

    part_ratings
    |> Enum.map(fn part_rating ->
      work(part_rating, workflows, "in", 0)
    end)
    |> Enum.sum()
  end

  def calculate_permutations(workflows, worfklow_key, instruction_number, ranges, cur_ranges) do
    case worfklow_key do
      "A" ->
        [cur_ranges.x, cur_ranges.m, cur_ranges.a, cur_ranges.s]
        |> Enum.map(&MapSet.size/1)
        |> Enum.product()

      "R" ->
        0

      _ ->
        instruction =
          workflows
          |> Map.get(worfklow_key)
          |> Enum.at(instruction_number)

        cond do
          instruction |> String.contains?("<") ->
            value = instruction |> ParseHelper.get_inbetween("<", ":") |> ParseHelper.get_number()
            part_key = instruction |> ParseHelper.get_before("<")
            next_worfklow_key = instruction |> ParseHelper.get_after(":")

            new_cur_ranges =
              case part_key do
                "x" -> %{cur_ranges | x: MapSet.filter(cur_ranges.x, fn v -> v < value end)}
                "m" -> %{cur_ranges | m: MapSet.filter(cur_ranges.m, fn v -> v < value end)}
                "a" -> %{cur_ranges | a: MapSet.filter(cur_ranges.a, fn v -> v < value end)}
                "s" -> %{cur_ranges | s: MapSet.filter(cur_ranges.s, fn v -> v < value end)}
              end

            first_result =
              calculate_permutations(
                workflows,
                next_worfklow_key,
                0,
                ranges,
                new_cur_ranges
              )

            new_cur_ranges =
              case part_key do
                "x" -> %{cur_ranges | x: MapSet.filter(cur_ranges.x, fn v -> v >= value end)}
                "m" -> %{cur_ranges | m: MapSet.filter(cur_ranges.m, fn v -> v >= value end)}
                "a" -> %{cur_ranges | a: MapSet.filter(cur_ranges.a, fn v -> v >= value end)}
                "s" -> %{cur_ranges | s: MapSet.filter(cur_ranges.s, fn v -> v >= value end)}
              end

            second_result =
              calculate_permutations(
                workflows,
                worfklow_key,
                instruction_number + 1,
                ranges,
                new_cur_ranges
              )

            first_result + second_result

          instruction |> String.contains?(">") ->
            value = instruction |> ParseHelper.get_inbetween(">", ":") |> ParseHelper.get_number()
            part_key = instruction |> ParseHelper.get_before(">")
            next_worfklow_key = instruction |> ParseHelper.get_after(":")

            new_cur_ranges =
              case part_key do
                "x" -> %{cur_ranges | x: MapSet.filter(cur_ranges.x, fn v -> v > value end)}
                "m" -> %{cur_ranges | m: MapSet.filter(cur_ranges.m, fn v -> v > value end)}
                "a" -> %{cur_ranges | a: MapSet.filter(cur_ranges.a, fn v -> v > value end)}
                "s" -> %{cur_ranges | s: MapSet.filter(cur_ranges.s, fn v -> v > value end)}
              end

            first_result =
              calculate_permutations(
                workflows,
                next_worfklow_key,
                0,
                ranges,
                new_cur_ranges
              )

            new_cur_ranges =
              case part_key do
                "x" -> %{cur_ranges | x: MapSet.filter(cur_ranges.x, fn v -> v <= value end)}
                "m" -> %{cur_ranges | m: MapSet.filter(cur_ranges.m, fn v -> v <= value end)}
                "a" -> %{cur_ranges | a: MapSet.filter(cur_ranges.a, fn v -> v <= value end)}
                "s" -> %{cur_ranges | s: MapSet.filter(cur_ranges.s, fn v -> v <= value end)}
              end

            second_result =
              calculate_permutations(
                workflows,
                worfklow_key,
                instruction_number + 1,
                ranges,
                new_cur_ranges
              )

            first_result + second_result

          true ->
            next_worfklow_key = instruction

            calculate_permutations(
              workflows,
              next_worfklow_key,
              0,
              ranges,
              cur_ranges
            )
        end
    end
  end

  def solve_b(input) do
    workflows = input |> parse_workflows()

    ranges = %{x: MapSet.new(), m: MapSet.new(), a: MapSet.new(), s: MapSet.new()}

    cur_ranges = %{
      x: MapSet.new(1..4000),
      m: MapSet.new(1..4000),
      a: MapSet.new(1..4000),
      s: MapSet.new(1..4000)
    }

    calculate_permutations(workflows, "in", 0, ranges, cur_ranges)
  end
end
