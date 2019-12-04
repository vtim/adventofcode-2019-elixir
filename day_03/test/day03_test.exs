defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "Full examples" do
    assert Day03.closest_cross_distance("R8,U5,L5,D3", "U7,R6,D4,L4") == 6

    assert Day03.closest_cross_distance(
             "R75,D30,R83,U83,L12,D49,R71,U7,L72",
             "U62,R66,U55,R34,D71,R55,D58,R83"
           ) == 159

    assert Day03.closest_cross_distance(
             "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
             "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
           ) == 135
  end

  test "Find intersections" do
    assert Day03.intersections("R8,U5,L5,D3", "U7,R6,D4,L4") == [{6, 5}, {3, 3}]
  end

  test "Calculate manhattan distance" do
    assert Day03.manhattan_distance({3, 3}) == 6
    assert Day03.manhattan_distance({5, 6}) == 11
  end
end

defmodule WireTest do
  use ExUnit.Case
  doctest Wire

  test "build simple routes" do
    assert Wire.execute_command("U1", {0, 0}) == [{0, 1}]
    assert Wire.execute_command("D1", {1, 1}) == [{1, 0}]
    assert Wire.execute_command("L1", {1, 1}) == [{0, 1}]
    assert Wire.execute_command("R1", {1, 1}) == [{2, 1}]

    assert Wire.execute_command("U3", {0, 1}) == [{0, 4}, {0, 3}, {0, 2}]
    assert Wire.execute_command("U5", {10, 10}) == [{10, 15}, {10, 14}, {10, 13}, {10, 12}, {10, 11}]
  end

  test "build command" do
    assert Wire.build("U1,U2") == [{0, 1}, {0, 2}, {0, 3}]
  end
end
