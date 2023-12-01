defmodule Day01 do
  def extract_numbers(input), do: Regex.scan(~r/\d/, input) |> List.flatten()

  def count(input) do
    first_digit = hd(input)
    last_digit = List.last(input, nil)

    case Integer.parse(first_digit <> last_digit) do
      {result, _} -> result
      :error -> 0
    end
  end

  def add_first_and_last_digit(inputs) do
    inputs
    |> Enum.map(&extract_numbers/1)
    |> Enum.map(&count/1)
    |> Enum.sum()
  end

  def replace(word) do
    word
    |> String.replace("one", "o1e")
    |> String.replace("two", "t2o")
    |> String.replace("three", "t3e")
    |> String.replace("four", "f4r")
    |> String.replace("five", "f5e")
    |> String.replace("six", "s6x")
    |> String.replace("seven", "s7n")
    |> String.replace("eight", "e8t")
    |> String.replace("nine", "n9e")
  end

  def solve_a(input) do
    input
    |> add_first_and_last_digit()
  end

  def solve_b(input) do
    input
    |> Enum.map(&replace/1)
    |> add_first_and_last_digit()
  end
end
