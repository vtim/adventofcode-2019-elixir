defmodule Day05 do
  def part1 do
    "input.txt"
    |> File.read!()
    |> IntCode.execute_binary()
  end
end
