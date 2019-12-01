defmodule Day01 do
  @moduledoc """
  Documentation for Day01.
  """

  def calculate_full_fuel_requirements() do
    "input.txt"
    |> File.read!
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> calculate_fuel_needed(&calculate_fuel_for_mass/1)
  end

  def calculate_part2() do
    "input.txt"
    |> File.read!
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> calculate_fuel_needed(&calculate_fuel_for_mass_including_fuel/1)
  end

  @doc """
  Calculate fuel required to launch a given module is based on its mass.

  To find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

  ## Examples

    iex> Day01.calculate_fuel_needed([12, 14], &Day01.calculate_fuel_for_mass/1)
    4

    iex> Day01.calculate_fuel_needed([], &Day01.calculate_fuel_for_mass/1)
    0

  """
  def calculate_fuel_needed([], _), do: 0
  def calculate_fuel_needed([head | tail], calc) do
    calc.(head) + calculate_fuel_needed(tail, calc)
  end

  @doc """
  Calculate fuel required to launch a given module is based on its mass.

  To find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

  ## Examples

    iex> Day01.calculate_fuel_for_mass(12)
    2

  """
  def calculate_fuel_for_mass(mass), do: floor(mass / 3) - 2

  @doc """
  Calculate fuel required to launch a given module is based on its mass, including additional fuel for the fuel you just added.

  Fuel itself requires fuel just like a module. However, that fuel also requires fuel, and that fuel requires fuel, and so on.
  Any mass that would require negative fuel should instead be treated as if it requires zero fuel; the remaining mass, if any,
  is instead handled by wishing really hard, which has no mass and is outside the scope of this calculation.

  ## Examples

    iex> Day01.calculate_fuel_for_mass_including_fuel(1969)
    966
  """
  def calculate_fuel_for_mass_including_fuel(mass) do
    case calculate_fuel_for_mass(mass) do
      fuel when fuel > 0 -> fuel + calculate_fuel_for_mass_including_fuel(fuel)
      _ -> 0
    end
  end
end
