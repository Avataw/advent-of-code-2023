defmodule Position do
  defstruct x: 0, y: 0

  def new([x, y]), do: %Position{x: x, y: y}

  def equals?(pos1, pos2) do
    pos1.x == pos2.x && pos1.y == pos2.y
  end

  def around(pos) do
    [
      up(pos),
      upRight(pos),
      right(pos),
      downRight(pos),
      down(pos),
      downLeft(pos),
      left(pos),
      upLeft(pos)
    ]
  end

  def up(%Position{x: x, y: y}), do: %Position{x: x, y: y - 1}

  def right(%Position{x: x, y: y}), do: %Position{x: x + 1, y: y}

  def down(%Position{x: x, y: y}), do: %Position{x: x, y: y + 1}

  def left(%Position{x: x, y: y}), do: %Position{x: x - 1, y: y}

  def upLeft(position), do: position |> up() |> left()

  def upRight(position), do: position |> up() |> right()

  def downLeft(position), do: position |> down() |> left()

  def downRight(position), do: position |> down() |> right()
end
