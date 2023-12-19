defmodule Day17 do
  defmodule Tile do
    defstruct pos: nil, heat: nil

    def new(pos, heat) do
      %Tile{pos: pos, heat: heat}
    end
  end

  def construct_grid(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {value, x}, acc2 ->
        pos = Position.new([x, y])
        value = value |> ParseHelper.get_number()
        acc2 |> Map.put(pos, Tile.new(pos, value))
      end)
    end)
  end

  def get_around(pos, last_steps) do
    last_steps = last_steps |> Enum.take(3)

    case last_steps do
      [:up, :up, :up] -> [Position.left(pos), Position.right(pos)]
      [:up, _, _] -> [Position.left(pos), Position.right(pos), Position.up(pos)]
      [:right, :right, :right] -> [Position.up(pos), Position.down(pos)]
      [:right, _, _] -> [Position.up(pos), Position.down(pos), Position.right(pos)]
      [:down, :down, :down] -> [Position.left(pos), Position.right(pos)]
      [:down, _, _] -> [Position.down(pos), Position.left(pos), Position.right(pos)]
      [:left, :left, :left] -> [Position.up(pos), Position.down(pos)]
      [:left, _, _] -> [Position.left(pos), Position.up(pos), Position.down(pos)]
      _ -> Position.adjacent(pos)
    end
  end

  def get_last_steps(current, pos, last_steps) do
    cond do
      Position.equals?(Position.down(current), pos) -> [:up | last_steps]
      Position.equals?(Position.up(current), pos) -> [:down | last_steps]
      Position.equals?(Position.left(current), pos) -> [:right | last_steps]
      Position.equals?(Position.right(current), pos) -> [:left | last_steps]
    end
  end

  def solve_a(input) do
    grid = input |> construct_grid()

    {start, target} =
      grid
      |> Map.values()
      |> Enum.min_max_by(fn tile -> {tile.pos.x, tile.pos.y} end)

    first_move = %{order: 0, pos: target.pos, heat_lossed: target.heat - start.heat, steps: []}

    alias Prioqueue.Helper

    queue =
      Prioqueue.new([first_move],
        cmp_fun: fn a, b -> Helper.cmp(a.order, b.order) end
      )

    visited = MapSet.new()

    [start]
    |> Stream.cycle()
    |> Enum.reduce_while({queue, visited}, fn target, {prio_queue, visited_cache} ->
      {:ok, {move, prio_queue}} =
        prio_queue |> Prioqueue.extract_min()

      case Position.equals?(move.pos, target.pos) && move.heat_lossed < 1250 do
        true ->
          {:halt, move.heat_lossed}

        false ->
          {:cont,
           get_around(move.pos, move.steps)
           |> Enum.filter(fn pos -> grid |> Map.has_key?(pos) end)
           |> Enum.reduce({prio_queue, visited_cache}, fn pos, {acc_queue, acc_cache} ->
             cache_key =
               [pos.x, pos.y, move.heat_lossed] |> Enum.join(",")

             case acc_cache |> MapSet.member?(cache_key) do
               true ->
                 {acc_queue, acc_cache}

               false ->
                 steps = get_last_steps(pos, move.pos, move.steps) |> Enum.take(3)
                 tile = grid |> Map.get(pos)

                 heat_lossed = move.heat_lossed + tile.heat
                 distance_to_target = Position.manhattan_distance_to(pos, target.pos)

                 step = %{
                   order: heat_lossed + distance_to_target,
                   pos: pos,
                   heat_lossed: move.heat_lossed + tile.heat,
                   steps: steps
                 }

                 {acc_queue |> Prioqueue.insert(step), acc_cache |> MapSet.put(cache_key)}
             end
           end)}
      end
    end)
  end

  def solve_b(input) do
    1
  end
end
