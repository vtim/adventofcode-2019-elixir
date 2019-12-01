defmodule Day01 do
  @moduledoc """
  Documentation for Day01.
  """

  def calculate_full_fuel_requirements() do
    "input.txt"
    |> File.read!
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> calculate_fuel_needed()
  end

  @doc """
  Calculate fuel required to launch a given module is based on its mass.

  To find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

  ## Examples

    iex> Day01.calculate_fuel_needed([12, 14])
    4

    iex> Day01.calculate_fuel_needed([])
    0

  """
  def calculate_fuel_needed([]), do: 0
  def calculate_fuel_needed([head | tail]) do
    calculate_fuel_for_module(head) + calculate_fuel_needed(tail)
  end

  @doc """
  Calculate fuel required to launch a given module is based on its mass.

  To find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

  ## Examples

    iex> Day01.calculate_fuel_for_module(12)
    2

  """
  def calculate_fuel_for_module(mass), do: floor(mass / 3) - 2
end
