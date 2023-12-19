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

  defmodule Factorial do
    def of(0), do: 1
    def of(n) when n > 0, do: n * of(n - 1)
  end
end
