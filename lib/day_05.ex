defmodule Mapper do
  defstruct dest_start: nil, source_start: nil, length: nil, diff: nil

  def new(input) do
    [dest_start, source_start, length] =
      String.split(input, " ")
      |> Enum.map(fn number ->
        {result, _} = Integer.parse(number)
        result
      end)

    diff = source_start - dest_start

    %Mapper{dest_start: dest_start, source_start: source_start, length: length, diff: diff}
  end

  def contains(mapper, input) do
    input >= mapper.source_start && input <= mapper.source_start + (mapper.length - 1)
  end

  def transform(mapper, input) do
    # IO.puts("Input #{input} diff #{mapper.diff} result #{input - mapper.diff}")
    input - mapper.diff
  end
end

defmodule Day05 do
  def get_maps(input) do
    input
    |> Enum.drop(1)
    |> Enum.reject(fn i -> i == "" end)
    |> Enum.chunk_by(fn input ->
      cond do
        String.contains?(input, "map:") -> false
        true -> true
      end
    end)
    |> Enum.drop(1)
    |> Enum.take_every(2)
    |> Enum.map(fn ranges ->
      Enum.map(ranges, &Mapper.new/1)
    end)
  end

  def get_seeds(input) do
    input
    |> ParseHelper.get_after("seeds: ")
    |> String.split(" ")
    |> Enum.map(fn number ->
      {result, _} = Integer.parse(number)
      result
    end)
  end

  def solve_a(input) do
    maps = get_maps(input)

    input
    |> hd()
    |> get_seeds()
    |> Enum.map(fn seed ->
      Enum.reduce(maps, seed, fn cur, acc ->
        matching_map =
          Enum.find(cur, fn map ->
            Mapper.contains(map, acc)
          end)

        case matching_map do
          nil -> acc
          _ -> Mapper.transform(matching_map, acc)
        end
      end)
    end)
    |> Enum.min()
  end

  def solve_b(input) do
    maps = get_maps(input)

    input
    |> hd()
    |> get_seeds()
    |> Enum.chunk_every(2)
    |> Enum.map(fn seed_range ->
      [start, length] = seed_range

      [start, start + length - 1]
      |> Enum.map(fn seed ->
        Enum.reduce(maps, seed, fn cur, acc ->
          matching_map =
            Enum.find(cur, fn map ->
              Mapper.contains(map, acc)
            end)

          case matching_map do
            nil -> acc
            _ -> Mapper.transform(matching_map, acc)
          end
        end)
      end)
      |> Enum.min()
    end)
    |> Enum.min()
  end
end
