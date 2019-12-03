defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "Simple full example" do
    assert Day03.closest_cross_distance("R8,U5,L5,D3", "U7,R6,D4,L4") == 6

    # assert Day03.closest_cross_distance(
    #          "R75,D30,R83,U83,L12,D49,R71,U7,L72",
    #          "U62,R66,U55,R34,D71,R55,D58,R83"
    #        ) == 159

    # assert Day03.closest_cross_distance(
    #          "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
    #          "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
    #        ) == 135
  end

  test "Find intersections" do
    assert Day03.intersections("R8,U5,L5,D3", "U7,R6,D4,L4") == [{3, 3}, {5, 6}]
  end

  test "Calculate manhattan distance" do
    assert Day03.manhattan_distance({3, 3}) == 6
    assert Day03.manhattan_distance({5, 6}) == 11
  end
end
