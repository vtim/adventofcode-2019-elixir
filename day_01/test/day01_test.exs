defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "calculate fuel needed for single module" do
    assert Day01.calculate_fuel_for_module(12) == 2
    assert Day01.calculate_fuel_for_module(14) == 2
    assert Day01.calculate_fuel_for_module(1969) == 654
    assert Day01.calculate_fuel_for_module(100756) == 33583
  end

  test "calculate fuel needed for list of models" do
    assert Day01.calculate_fuel_needed([12, 14]) == 4
    assert Day01.calculate_fuel_needed([12, 14, 1969, 100756]) == 2 + 2 + 654 + 33583
  end
end
