defmodule Day10 do
  defmodule Tile do
    defstruct pos: nil, connections: [], visited: false, pipe: nil, distance: 0

    def new(pos, character) do
      connections =
        case character do
          "|" -> [Position.up(pos), Position.down(pos)]
          "-" -> [Position.left(pos), Position.right(pos)]
          "L" -> [Position.up(pos), Position.right(pos)]
          "J" -> [Position.up(pos), Position.left(pos)]
          "7" -> [Position.down(pos), Position.left(pos)]
          "F" -> [Position.down(pos), Position.right(pos)]
          "." -> []
          "S" -> [Position.up(pos), Position.right(pos), Position.down(pos), Position.left(pos)]
        end

      %Tile{pos: pos, connections: connections, visited: false, pipe: character}
    end
  end

  def construct_tiles(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, acc ->
      String.graphemes(line)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, x}, acc2 ->
        pos = Position.new([x, y])
        tile = Tile.new(pos, char)
        Map.put(acc2, Position.new([x, y]), tile)
      end)
    end)
  end

  def traverse(tile_pos, tiles, length) do
    tile = tiles |> Map.get(tile_pos)

    tiles =
      tiles
      |> Map.update!(tile_pos, fn current_tile ->
        %{current_tile | visited: true}
      end)

    if tile.visited do
      tiles
    else
      tiles =
        Map.update!(tiles, tile_pos, fn current_tile ->
          %{current_tile | distance: length}
        end)

      tile.connections
      |> Enum.filter(fn connection ->
        con = Map.get(tiles, connection)

        if con == nil || con.pipe == "." do
          false
        else
          con.visited == false
        end
      end)
      |> Enum.reduce(tiles, fn connection, acc -> traverse(connection, acc, length + 1) end)
    end
  end

  def solve_a(input) do
    tiles = input |> construct_tiles()

    start = tiles |> Map.values() |> Enum.find(fn tile -> tile.pipe == "S" end)

    result =
      start.pos
      |> traverse(tiles, 0)
      |> Map.values()
      |> Enum.map(fn tile -> tile.distance end)
      |> Enum.max()

    round((result + 1) / 2)
  end

  def solve_b(input) do
    tiles = input |> construct_tiles()

    height = input |> length()
    width = input |> hd() |> String.length()

    start = tiles |> Map.values() |> Enum.find(fn tile -> tile.pipe == "S" end)

    traversed =
      start.pos
      |> traverse(tiles, 0)

    0..(height - 1)
    |> Enum.reduce(0, fn y, acc ->
      line =
        0..(width - 1)
        |> Enum.map(fn x ->
          pos = Position.new([x, y])
          Map.get(traversed, pos)
        end)

      visited =
        line
        |> Enum.filter(fn t -> t.visited && t.pipe == "|" end)
        |> Enum.map(fn t -> t.pos.x end)
        |> IO.inspect()

      result =
        line
        |> Enum.filter(fn t -> t.visited == false end)
        |> Enum.count(fn t ->
          x = t.pos.x

          left = visited |> Enum.count(fn vis_x -> vis_x < x end) |> IO.inspect()

          rem(left, 2) == 1
        end)
        |> IO.inspect()

      acc + result
    end)
  end
end
