defmodule Day02 do
  @moduledoc """
  Documentation for Day02.
  """

  @doc """
  Executes part 1 of Day 2
  """
  def execute_part1 do
    input = File.read!("input.txt")

    input
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> IntCode.process_list()
    |> Enum.at(0)
    |> IO.puts()
  end

  @doc """
  Executes part 2 of Day 2
  """
  def execute_part2 do
    input =
      File.read!("input.txt")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    for i <- 0..99 do
      input = List.replace_at(input, 1, i)

      for j <- 0..99 do
        input = List.replace_at(input, 2, j)
        res = IntCode.process_list(input)

        if Enum.at(res, 0) == 19_690_720 do
          IO.puts("Found it! The answer is #{(i * 100) + j}")
        end
      end
    end
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

  def process_list(list) do
    list
    |> operate()
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
