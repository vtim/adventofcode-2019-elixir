defmodule IntCode do
  @doc """
  Executes a binary Intcode program.

  ## Examples

    iex> IntCode.execute_binary("1,1,1,0,99")
    "2,1,1,0,99"
  """
  @spec execute_binary(binary) :: binary
  def execute_binary(program) do
    program
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> execute()
    |> Enum.join(",")
  end

  @doc """
  Executes a List Intcode program.

  ## Examples

    iex> IntCode.execute_list([1,1,1,0,99])
    [2,1,1,0,99]
  """
  def execute_list(program) do
    program
    |> execute()
  end

  @spec execute(any, integer) :: [any]
  def execute(program, idx \\ 0) do
    operation = Enum.at(program, idx)

    case perform(operation, program, idx) do
      {new_program, :halt} -> new_program
      {new_program, new_index} -> execute(new_program, new_index)
    end
  end

  defp perform(operation, program, idx)

  defp perform(99, program, _idx), do: {program, :halt}

  defp perform(1, program, idx) do
    idx1 = Enum.at(program, idx + 1)
    idx2 = Enum.at(program, idx + 2)

    result = Enum.at(program, idx1) + Enum.at(program, idx2)

    result_index = Enum.at(program, idx + 3)
    new_program = List.replace_at(program, result_index, result)
    {new_program, idx + 4}
  end

  defp perform(2, program, idx) do
    idx1 = Enum.at(program, idx + 1)
    idx2 = Enum.at(program, idx + 2)

    result = Enum.at(program, idx1) * Enum.at(program, idx2)

    result_index = Enum.at(program, idx + 3)
    new_program = List.replace_at(program, result_index, result)
    {new_program, idx + 4}
  end

  defp perform(3, program, idx) do
    result = IO.gets("Input number") |> String.to_integer()
    result_index = Enum.at(program, idx + 1)
    new_program = List.replace_at(program, result_index, result)
    {new_program, idx + 2}
  end

  defp perform(4, program, idx) do
    output_idx = Enum.at(program, idx + 1)
    output_value = Enum.at(program, output_idx)
    IO.puts(output_value)
    {program, idx + 2}
  end
end
