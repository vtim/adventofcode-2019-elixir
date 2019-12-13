defmodule Day05 do
  def part1 do
    IO.puts("Enter 1 as the input below:")

    # This will output 6731945
    execute()
  end

  def part2 do
    IO.puts("Enter 5 as the input below:")

    # This will output 9571668
    execute()
  end

  defp execute do
    "input.txt"
    |> File.read!()
    |> IntCode.execute_binary()
  end
end
