defmodule Day01 do
  def solve_a() do
    input =
      FileHelper.read_as_lines(13)
      |> Enum.map(fn word ->
        String.split(word, "")
        |> Enum.map(fn letter ->
          case Integer.parse(letter) do
            {result, _} -> result
            :error -> nil
          end
        end)
        |> Enum.reject(fn v -> v == nil end)
      end)
      |> Enum.reduce(0, fn cur, acc ->
        first = hd(cur) |> Integer.to_string()
        last = List.last(cur, nil) |> Integer.to_string()

        str = first <> last

        {result, _} = Integer.parse(str)

        acc = acc + result
      end)
  end

  def solve_b() do
    input =
      FileHelper.read_as_lines(13)
      |> Enum.map(fn word ->
        word
        |> replace()
        |> String.split("")
        |> Enum.map(fn letter ->
          case Integer.parse(letter) do
            {result, _} -> result
            :error -> nil
          end
        end)
        |> Enum.reject(fn v -> v == nil end)
      end)
      |> Enum.reduce(0, fn cur, acc ->
        first = hd(cur) |> Integer.to_string()
        last = List.last(cur, nil) |> Integer.to_string()

        str = first <> last

        {result, _} = Integer.parse(str)

        acc = acc + result
      end)
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
    |> IO.inspect()
  end
end
