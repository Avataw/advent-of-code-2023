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

        case instruction do
          "A" ->
            part_rating |> Map.values() |> Enum.sum()

          "R" ->
            0

          _ ->
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

  def solve_b(input) do
    1
  end
end
