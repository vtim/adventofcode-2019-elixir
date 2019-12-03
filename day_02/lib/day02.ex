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

    iex> IntCode.process("1,1,1,0,99")
    "2,1,1,0,99"
  """
  @spec process(binary) :: binary
  def process(program) do
    program
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> operate()
    |> Enum.join(",")
  end

  @spec operate(any, integer) :: [any]
  def operate(list, idx \\ 0) do
    case Enum.at(list, idx) do
      99 -> list
      1 -> operate(perform(list, idx, &Kernel.+/2), idx + 4)
      2 -> operate(perform(list, idx, &Kernel.*/2), idx + 4)
    end
  end

  @spec perform([any], integer, (integer(), integer() -> integer())) :: [any]
  def perform(list, idx, op) do
    idx1 = Enum.at(list, idx + 1)
    idx2 = Enum.at(list, idx + 2)
    result = op.(Enum.at(list, idx1), Enum.at(list, idx2))

    resultIndex = Enum.at(list, idx + 3)
    List.replace_at(list, resultIndex, result)
  end
end
