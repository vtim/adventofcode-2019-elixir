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
    # IO.puts("Execute program at idx #{idx}")
    # IO.inspect(program)
    operation = Enum.at(program, idx)
    opcode = rem(operation, 100)
    parameter_modes = floor(operation / 100)

    case perform(opcode, parameter_modes, program, idx) do
      {new_program, :halt} -> new_program
      {new_program, new_index} -> execute(new_program, new_index)
    end
  end

  defp perform(opcode, parameter_modes, program, idx)

  defp perform(99, _parameter_modes, program, _idx), do: {program, :halt}

  defp perform(1, parameter_modes, program, idx) do
    param1 = get_param(program, idx, 1, parameter_modes)
    param2 = get_param(program, idx, 2, parameter_modes)

    result = param1 + param2

    new_program = set_result(program, result, idx, 3, parameter_modes)
    {new_program, idx + 4}
  end

  defp perform(2, parameter_modes, program, idx) do
    param1 = get_param(program, idx, 1, parameter_modes)
    param2 = get_param(program, idx, 2, parameter_modes)

    result = param1 * param2

    new_program = set_result(program, result, idx, 3, parameter_modes)
    {new_program, idx + 4}
  end

  defp perform(3, parameter_modes, program, idx) do
    result = IO.gets("Input number: ") |> String.replace("\n", "") |> String.to_integer()
    new_program = set_result(program, result, idx, 1, parameter_modes)
    {new_program, idx + 2}
  end

  defp perform(4, parameter_modes, program, idx) do
    output_value = get_param(program, idx, 1, parameter_modes)
    IO.puts(output_value)
    {program, idx + 2}
  end

  defp perform(5, parameter_modes, program, idx) do
    first_param = get_param(program, idx, 1, parameter_modes)

    new_index =
      case first_param do
        0 -> idx + 3
        _ -> get_param(program, idx, 2, parameter_modes)
      end

    {program, new_index}
  end

  defp perform(6, parameter_modes, program, idx) do
    first_param = get_param(program, idx, 1, parameter_modes)

    new_index =
      case first_param do
        0 -> get_param(program, idx, 2, parameter_modes)
        _ -> idx + 3
      end

    {program, new_index}
  end

  defp perform(7, parameter_modes, program, idx) do
    param1 = get_param(program, idx, 1, parameter_modes)
    param2 = get_param(program, idx, 2, parameter_modes)

    result =
      case param1 < param2 do
        true -> 1
        false -> 0
      end

    new_program = set_result(program, result, idx, 3, parameter_modes)
    {new_program, idx + 4}
  end

  defp perform(8, parameter_modes, program, idx) do
    param1 = get_param(program, idx, 1, parameter_modes)
    param2 = get_param(program, idx, 2, parameter_modes)

    result =
      case param1 == param2 do
        true -> 1
        false -> 0
      end

    new_program = set_result(program, result, idx, 3, parameter_modes)
    {new_program, idx + 4}
  end

  def get_param(program, idx, param_position, parameter_modes) do
    # IO.puts("Get param #{idx}, #{param_position}, #{parameter_modes}")
    # IO.inspect(program)
    # IO.puts("---")
    param_index = Enum.at(program, idx + param_position)
    quotient = trunc(:math.pow(10, param_position - 1))
    param_mode = rem(div(parameter_modes, quotient), 10)
    # IO.puts("> param_index = #{param_index}; param_mode = #{param_mode}")

    case param_mode do
      0 ->
        Enum.at(program, param_index)

      1 ->
        param_index
    end
  end

  def set_result(program, value, idx, result_position, _parameter_modes) do
    # IO.puts("Setting value #{value} at index #{idx} + #{result_position}")
    # IO.inspect(program)
    result_index = Enum.at(program, idx + result_position)
    List.replace_at(program, result_index, value)
  end
end
