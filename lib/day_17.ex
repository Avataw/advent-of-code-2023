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

    first_move = %{order: 0, pos: start.pos, heat_lossed: 0, steps: []}

    alias Prioqueue.Helper

    queue =
      Prioqueue.new([first_move],
        cmp_fun: fn a, b -> Helper.cmp(a.order, b.order) end
      )

    visited = MapSet.new()

    [target]
    |> Stream.cycle()
    |> Enum.reduce_while({queue, visited}, fn target, {prio_queue, visited_cache} ->
      {:ok, {move, prio_queue}} =
        prio_queue |> Prioqueue.extract_min()

      case Position.equals?(move.pos, target.pos) do
        true ->
          {:halt, move.heat_lossed}

        false ->
          {:cont,
           get_around(move.pos, move.steps)
           |> Enum.filter(fn pos -> grid |> Map.has_key?(pos) end)
           |> Enum.reduce({prio_queue, visited_cache}, fn pos, {acc_queue, acc_cache} ->
             direction =
               cond do
                 move.steps |> length() == 0 -> ""
                 true -> move.steps |> Enum.take(7) |> Enum.join()
               end

             cache_key = [pos.x, pos.y, direction] |> Enum.join(",")

             case acc_cache |> MapSet.member?(cache_key) do
               true ->
                 {acc_queue, acc_cache}

               false ->
                 steps = get_last_steps(pos, move.pos, move.steps)
                 tile = grid |> Map.get(pos)

                 heat_lossed = move.heat_lossed * 50
                 distance_to_target = Position.manhattan_distance_to(pos, target.pos) * 100

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

  def get_around_b(pos, last_steps) do
    last_steps = last_steps |> Enum.take(10)

    last_step = last_steps |> hd()

    locked = last_steps |> Enum.take_while(fn step -> step == last_step end)

    cond do
      locked |> length() < 4 ->
        case last_step do
          :up -> [Position.up(pos)]
          :right -> [Position.right(pos)]
          :down -> [Position.down(pos)]
          :left -> [Position.left(pos)]
        end

      locked |> length() < 10 ->
        case last_step do
          :up -> [Position.up(pos), Position.left(pos), Position.right(pos)]
          :right -> [Position.up(pos), Position.right(pos), Position.down(pos)]
          :down -> [Position.left(pos), Position.down(pos), Position.right(pos)]
          :left -> [Position.left(pos), Position.down(pos), Position.up(pos)]
        end

      true ->
        case last_step do
          :up -> [Position.left(pos), Position.right(pos)]
          :right -> [Position.up(pos), Position.down(pos)]
          :down -> [Position.left(pos), Position.right(pos)]
          :left -> [Position.down(pos), Position.up(pos)]
        end
    end
  end

  def solve_b(input) do
    grid = input |> construct_grid()

    {start, target} =
      grid
      |> Map.values()
      |> Enum.min_max_by(fn tile -> {tile.pos.x, tile.pos.y} end)

    right = Position.right(start.pos)
    right_tile = Map.get(grid, right)

    down = Position.down(start.pos)
    down_tile = Map.get(grid, down)

    first_move = %{order: 0, pos: right, heat_lossed: right_tile.heat, steps: [:right]}
    second_move = %{order: 0, pos: down, heat_lossed: down_tile.heat, steps: [:down]}

    alias Prioqueue.Helper

    queue =
      Prioqueue.new([first_move, second_move],
        cmp_fun: fn a, b -> Helper.cmp(a.order, b.order) end
      )

    visited = MapSet.new()

    [target]
    |> Stream.cycle()
    |> Enum.reduce_while({queue, visited}, fn target, {prio_queue, visited_cache} ->
      {:ok, {move, prio_queue}} =
        prio_queue |> Prioqueue.extract_min()

      last_step = move.steps |> hd()

      last_steps = move.steps |> Enum.take_while(fn s -> s == last_step end)

      skip = length(last_steps) < 4

      case Position.equals?(move.pos, target.pos) && !skip do
        true ->
          IO.inspect(move.steps)
          {:halt, move.heat_lossed}

        false ->
          {:cont,
           get_around_b(move.pos, move.steps)
           |> Enum.filter(fn pos -> grid |> Map.has_key?(pos) end)
           |> Enum.reduce({prio_queue, visited_cache}, fn pos, {acc_queue, acc_cache} ->
             direction =
               cond do
                 move.steps |> length() == 0 -> ""
                 true -> move.steps |> Enum.take(20) |> Enum.join()
               end

             cache_key = [pos.x, pos.y, direction] |> Enum.join(",")

             case acc_cache |> MapSet.member?(cache_key) do
               true ->
                 {acc_queue, acc_cache}

               false ->
                 steps = get_last_steps(pos, move.pos, move.steps)
                 tile = grid |> Map.get(pos)

                 heat_lossed = move.heat_lossed * 2
                 distance_to_target = Position.manhattan_distance_to(pos, target.pos) * 5

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
end
