defmodule Day06Test do
  use ExUnit.Case
  doctest Day06
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

  test "Convert OrbitMap to List with given object" do
    map = %{"A" => "COM", "B" => "A", "YOU" => "B", "C" => "A", "SAN" => "C"}
    assert OrbitMap.list_for(map, "YOU") == ["COM", "A", "B", "YOU"]
    assert OrbitMap.list_for(map, "SAN") == ["COM", "A", "C", "SAN"]

    assert OrbitMap.count_transfers(map, "YOU", "SAN") == 2
  end

  test "Example orbit hop count" do
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
    K)YOU
    I)SAN
    """ |> OrbitMap.parse |> OrbitMap.count_transfers("YOU", "SAN") == 4
  end
end
