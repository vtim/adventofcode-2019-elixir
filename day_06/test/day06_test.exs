defmodule Day06Test do
  use ExUnit.Case
  doctest Day06

  test "greets the world" do
    assert Day06.hello() == :world
  end
end

defmodule OrbitMapTest do
  use ExUnit.Case
  doctest OrbitMap

  test "Example checksum" do
    assert %{
             "B" => "COM",
             "C" => "B",
             "D" => "C",
             "E" => "D",
             "F" => "E",
             "G" => "B",
             "H" => "G",
             "I" => "D",
             "J" => "E",
             "K" => "J",
             "L" => "K"
           }
           |> OrbitMap.orbit_count() == 42
  end

  test "Parse map data" do
    assert """
           COM)B
           B)C
           C)D
           D)E
           E)F
           B)G
           G)H
           D)I
           E)J
           J)K
           K)L
           """
           |> OrbitMap.parse() == %{
             "B" => "COM",
             "C" => "B",
             "D" => "C",
             "E" => "D",
             "F" => "E",
             "G" => "B",
             "H" => "G",
             "I" => "D",
             "J" => "E",
             "K" => "J",
             "L" => "K"
           }
  end
end
