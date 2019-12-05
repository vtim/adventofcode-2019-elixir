defmodule Day04 do
  def part1 do
    count =
      264_360..746_325
      |> Enum.count(fn x -> Password.validate(x) end)

    IO.puts("Part 1: Found #{count} possible passwords")
  end

  def part2 do
    count =
      264_360..746_325
      |> Enum.count(fn x -> Password.validate(x) && Password.validate_part2(x) end)

    IO.puts("Part 2: Found #{count} possible passwords")
  end
end

defmodule Password do
  def validate(password) do
    validate_six_digit_number(password) &&
      validate_range(password, 264_360..746_325) &&
      validate_adjacent(password) &&
      validate_never_decrease(password)
  end

  defp validate_six_digit_number(password) do
    is_number(password) &&
      String.length(Integer.to_string(password)) == 6
  end

  defp validate_range(password, range) do
    password in range
  end

  defp validate_adjacent(password) do
    list1 = Integer.to_charlist(password)

    list2 = Enum.drop(list1, 1)

    pairs =
      Enum.zip(list1, list2)
      |> Enum.find(fn {a, b} -> a == b end)

    pairs != nil
  end

  defp validate_never_decrease(password) do
    list1 = Integer.to_charlist(password)
    list2 = Enum.drop(list1, 1)

    pairs =
      Enum.zip(list1, list2)
      |> Enum.find(fn {a, b} -> b < a end)

    pairs == nil
  end

  def validate_part2(password) do
    password
    |> Integer.to_charlist()
    |> Enum.map(fn x -> {x, 1} end)
    |> sieve()
    |> Enum.find(fn {_, count} -> count == 2 end) !=
      nil
  end

  def sieve(list, index \\ 0)
  def sieve(list, index) when index == length(list) - 1, do: list

  def sieve(list, index) do
    {current_value, current_count} = Enum.at(list, index)
    {next_value, next_count} = Enum.at(list, index + 1)

    if current_value == next_value do
      new_list =
        list
        |> List.delete_at(index + 1)
        |> List.replace_at(index, {current_value, current_count + next_count})

      sieve(new_list, index)
    else
      sieve(list, index + 1)
    end
  end
end
