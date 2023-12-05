defmodule Mapper do
  defstruct dest_start: nil, source_start: nil, length: nil, diff: nil

  def new(input) do
    [dest_start, source_start, length] =
      String.split(input, " ")
      |> Enum.map(fn number ->
        {result, _} = Integer.parse(number)
        result
      end)

    diff = dest_start - source_start

    %Mapper{dest_start: dest_start, source_start: source_start, length: length, diff: diff}
  end

  def contains(mapper, input) do
    input >= mapper.dest_start && input <= mapper.dest_start + (mapper.length - 1)
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
    |> Enum.reverse()
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

    seeds = input |> hd() |> get_seeds()

    379_811_651..379_811_651
    |> Enum.map(fn location ->
      seed =
        Enum.reduce(maps, location, fn cur, acc ->
          matching_map =
            Enum.find(cur, fn map ->
              Mapper.contains(map, acc)
            end)

          case matching_map do
            nil -> acc
            _ -> Mapper.transform(matching_map, acc)
          end
        end)

      if Enum.member?(seeds, seed) do
        location
      else
        nil
      end
    end)
    |> Enum.min()
  end

  def get_all_seeds(input) do
    input
    |> hd()
    |> get_seeds()
    |> Enum.chunk_every(2)
  end

  def solve_b(input) do
    maps = get_maps(input)

    seeds = input |> get_all_seeds()

    27_992_443..27_992_443
    |> Enum.map(fn location ->
      seed =
        Enum.reduce(maps, location, fn cur, acc ->
          matching_map =
            Enum.find(cur, fn map ->
              Mapper.contains(map, acc)
            end)

          case matching_map do
            nil -> acc
            _ -> Mapper.transform(matching_map, acc)
          end
        end)

      is_valid_seed =
        seeds
        |> Enum.any?(fn seed_range ->
          [start, last] = seed_range

          seed >= start && seed <= start + last + 1
        end)

      if is_valid_seed do
        location
      else
        nil
      end
    end)
    |> Enum.min()
  end
end
