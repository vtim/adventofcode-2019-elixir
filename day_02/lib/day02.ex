defmodule Day02 do
  @moduledoc """
  Documentation for Day02.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day02.hello()
      :world

  """
  def hello do
    :world
  end
end

defmodule IntCode do
  @doc """
  Process an Intcode program.

  ## Examples

    iex> IntCode.process("1,1,1,0")
    "1,1,1,2"
  """
  @spec process(binary) :: binary
  def process(program) do
    program
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.replace_at(3, 2)
    |> Enum.join(",")
  end
end
