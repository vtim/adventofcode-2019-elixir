defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "calculate fuel needed for single module" do
    assert Day01.calculate_fuel_for_mass(12) == 2
    assert Day01.calculate_fuel_for_mass(14) == 2
    assert Day01.calculate_fuel_for_mass(1969) == 654
    assert Day01.calculate_fuel_for_mass(100756) == 33583
  end

  test "calculate fuel needed for list of models" do
    assert Day01.calculate_fuel_needed([12, 14], &Day01.calculate_fuel_for_mass/1) == 4
    assert Day01.calculate_fuel_needed([12, 14, 1969, 100756], &Day01.calculate_fuel_for_mass/1) == 2 + 2 + 654 + 33583
  end

  test "calculate fuel needed for mass, including fuel for mass of fuel" do
    assert Day01.calculate_fuel_for_mass_including_fuel(12) == 2
    assert Day01.calculate_fuel_for_mass_including_fuel(14) == 2
    assert Day01.calculate_fuel_for_mass_including_fuel(1969) == 966
    assert Day01.calculate_fuel_for_mass_including_fuel(100756) == 50346
  end
end
