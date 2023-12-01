defmodule StringHelper do
  @doc """

  Returns a map of every character and it's occurence in the string

  ## Examples
    iex> StringHelper.count_letters("abbccc")
    %{"a" => 1, "b" => 2, "c" => 3}

  """
  def count_letters(string) do
    string
    # get's
    |> String.graphemes()
    |> Enum.reduce(Map.new(), fn char, occs ->
      Map.update(occs, char, 1, &(&1 + 1))
    end)
  end

  @doc """

  Split a string at a certain value and turn the result into an integer tuple

  ## Examples
    iex> StringHelper.split_to_int_tuple("1,2", ",")
    {1,2}
  """
  def split_to_int_tuple(input, split_char) do
    input
    |> String.split(split_char)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  @doc """

  Appends something to a string.

  ## Examples
    iex> StringHelper.append("ab", "c")
    "abc"
  """
  @spec append(String.t(), String.t()) :: String.t()
  def append(input, string) do
    "#{input}#{string}"
  end

  @doc """

  Get's all the lower case letters.

  ## Examples
    iex> StringHelper.alphabetize()
    ["a","b","c","d","e","f","g","h","i",
    "j","k","l","m","n","o","p","q","r",
    "s","t","u","v","w","x","y","z"]
  """
  @spec alphabetize() :: [String.t()]
  def alphabetize() do
    ?a..?z
    |> Enum.map(&<<&1::utf8>>)
  end
end
