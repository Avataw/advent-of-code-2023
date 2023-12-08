defmodule MathHelper do
  @doc """

  Returns the least common denominator of two numbers

  ## Examples
    iex> MathHelper.lcd(3,5)
    15
  """
  def lcd(a, b) do
    (abs(a * b) / Integer.gcd(a, b)) |> round
  end
end
