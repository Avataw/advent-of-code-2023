defmodule Day15 do
  def calc_hash(string) do
    string
    |> String.to_charlist()
    |> Enum.reduce(0, fn ascii_value, acc ->
      ((acc + ascii_value) * 17) |> rem(256)
    end)
  end

  def solve_a(input) do
    input
    |> hd()
    |> String.split(",")
    |> Enum.map(&calc_hash/1)
    |> Enum.sum()
  end

  def solve_b(input) do
    input
    |> hd()
    |> String.split(",")
    |> Enum.reduce(%{}, fn step, acc ->
      equals = String.contains?(step, "=")

      case equals do
        true ->
          [label, focal_length] = String.split(step, "=")
          focal_length = ParseHelper.get_number(focal_length)

          box_key = calc_hash(label)

          box_content = Map.get(acc, box_key, [])

          contains =
            box_content
            |> Enum.filter(fn {content_label, _} ->
              content_label == label
            end)
            |> length()

          box_content =
            case contains > 0 do
              true ->
                box_content
                |> Enum.map(fn {content_label, content_focal_length} ->
                  cond do
                    content_label == label -> {content_label, focal_length}
                    true -> {content_label, content_focal_length}
                  end
                end)

              false ->
                [{label, focal_length} | box_content]
            end

          Map.update(acc, box_key, box_content, fn _ -> box_content end)

        false ->
          [label, _] = String.split(step, "-")

          box_key = calc_hash(label)

          box_content = Map.get(acc, box_key, [])

          box_content =
            box_content |> Enum.reject(fn {content_label, _} -> content_label == label end)

          Map.update(acc, box_key, box_content, fn _ -> box_content end)
      end
    end)
    |> Enum.reject(fn {_, lenses} -> length(lenses) == 0 end)
    |> Enum.map(fn {box_number, lenses} ->
      {box_number, lenses}

      lenses
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn {{_, focal_length}, slot_index} ->
        (box_number + 1) * (slot_index + 1) * focal_length
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end
end
