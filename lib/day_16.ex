defmodule Day16 do
  defmodule Beam do
    defstruct pos: nil, direction: nil, done: false

    def new(pos, direction) do
      %Beam{pos: pos, direction: direction, done: false}
    end

    def traverse(grid, beam) do
      space = Map.get(grid, beam.pos)

      case space do
        nil ->
          [%Beam{beam | done: true}]

        "." ->
          [%Beam{beam | pos: move(beam.pos, beam.direction)}]

        "/" ->
          direction = rotate(beam.direction, space)

          beam = %Beam{beam | direction: direction}
          [%Beam{beam | pos: move(beam.pos, beam.direction)}]

        "(" ->
          direction = rotate(beam.direction, space)

          beam = %Beam{beam | direction: direction}
          [%Beam{beam | pos: move(beam.pos, beam.direction)}]

        "|" when beam.direction == :up or beam.direction == :down ->
          [%Beam{beam | pos: move(beam.pos, beam.direction)}]

        "-" when beam.direction == :left or beam.direction == :right ->
          [%Beam{beam | pos: move(beam.pos, beam.direction)}]

        "|" ->
          split(beam, space)

        "-" ->
          split(beam, space)
      end
    end

    def split(beam, symbol) do
      case symbol do
        "|" ->
          [
            %Beam{pos: Position.up(beam.pos), direction: :up, done: false},
            %Beam{pos: Position.down(beam.pos), direction: :down, done: false}
          ]

        "-" ->
          [
            %Beam{pos: Position.left(beam.pos), direction: :left, done: false},
            %Beam{pos: Position.right(beam.pos), direction: :right, done: false}
          ]
      end
    end

    def rotate(direction, symbol) do
      case symbol do
        "/" ->
          case direction do
            :up -> :right
            :right -> :up
            :down -> :left
            :left -> :down
          end

        "(" ->
          case direction do
            :up -> :left
            :right -> :down
            :down -> :right
            :left -> :up
          end
      end
    end

    def move(pos, direction) do
      case direction do
        :up -> Position.up(pos)
        :right -> Position.right(pos)
        :down -> Position.down(pos)
        :left -> Position.left(pos)
      end
    end
  end

  def construct_grid(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, x}, acc2 ->
        Map.put(acc2, Position.new([x, y]), char)
      end)
    end)
  end

  def solve_a(input) do
    grid = construct_grid(input)

    start = Position.new([0, 0])

    dp = %{}

    visited =
      0..700
      |> Enum.reduce_while({dp, [Beam.new(start, :right)], MapSet.new()}, fn _,
                                                                             {mem, beams, visited} ->
        done = beams |> Enum.all?(fn beam -> beam.done end)

        new_beams =
          beams
          |> Enum.reject(fn beam ->
            Map.get(mem, beam.pos) == beam.direction
          end)

        mem =
          new_beams
          |> Enum.reduce(mem, fn beam, acc ->
            Map.put(acc, beam.pos, beam.direction)
          end)

        visited =
          new_beams
          |> Enum.reject(fn beam -> Map.get(grid, beam.pos) == nil end)
          |> Enum.reduce(visited, fn beam, acc ->
            MapSet.put(acc, beam.pos)
          end)

        cond do
          done ->
            {:halt, MapSet.size(visited)}

          true ->
            beams =
              new_beams
              |> Enum.flat_map(fn beam -> Beam.traverse(grid, beam) end)
              |> Enum.reject(fn beam -> beam.done end)

            {:cont, {mem, beams, visited}}
        end
      end)

    visited
  end

  # 7997 too low
  def solve(grid, starting_beam) do
    0..2000
    |> Enum.reduce_while({%{}, [starting_beam], MapSet.new()}, fn _, {mem, beams, visited} ->
      done = beams |> Enum.all?(fn beam -> beam.done end)

      new_beams =
        beams
        |> Enum.reject(fn beam ->
          Map.get(mem, beam.pos) == beam.direction
        end)

      mem =
        new_beams
        |> Enum.reduce(mem, fn beam, acc ->
          Map.put(acc, beam.pos, beam.direction)
        end)

      visited =
        new_beams
        |> Enum.reject(fn beam -> Map.get(grid, beam.pos) == nil end)
        |> Enum.reduce(visited, fn beam, acc ->
          MapSet.put(acc, beam.pos)
        end)

      cond do
        done ->
          {:halt, MapSet.size(visited)}

        true ->
          beams =
            new_beams
            |> Enum.flat_map(fn beam -> Beam.traverse(grid, beam) end)
            |> Enum.reject(fn beam -> beam.done end)

          {:cont, {mem, beams, visited}}
      end
    end)
  end

  def solve_b(input) do
    grid = construct_grid(input)

    start = Position.new([0, 0])

    solve(grid, Beam.new(start, :right))

    max_y = length(input)
    max_x = input |> hd() |> String.graphemes() |> length()

    top_row =
      grid
      |> Map.filter(fn {pos} ->
        pos.y == 0
      end)
      |> Map.keys()
      |> Enum.map(fn pos -> Beam.new(pos, :down) end)

    bottom_row =
      grid
      |> Map.filter(fn {pos} ->
        pos.y == max_y - 1
      end)
      |> Map.keys()
      |> Enum.map(fn pos -> Beam.new(pos, :up) end)

    left_row =
      grid
      |> Map.filter(fn {pos} ->
        pos.x == 0
      end)
      |> Map.keys()
      |> Enum.map(fn pos -> Beam.new(pos, :right) end)

    right_row =
      grid
      |> Map.filter(fn {pos} ->
        pos.x == max_x - 1
      end)
      |> Map.keys()
      |> Enum.map(fn pos -> Beam.new(pos, :left) end)

    [top_row, right_row, bottom_row, left_row]
    |> Enum.map(fn row ->
      row |> Enum.map(fn beam -> solve(grid, beam) end) |> Enum.max()
    end)
    |> Enum.max()
  end
end
