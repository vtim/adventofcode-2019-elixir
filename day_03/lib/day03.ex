defmodule Day03 do
  @moduledoc """
  Documentation for Day03.
  """
  def part1 do
    answer =
      closest_intersection_distance(
        "R992,U221,L822,U805,R667,D397,L969,U433,R918,D517,L494,U909,L224,D738,R247,D312,L803,D656,L571,D968,L392,D332,L581,U487,R522,D780,L74,D561,L246,U380,L125,U11,R735,D761,R482,D208,R985,D991,L352,U140,L586,D492,L777,U96,R682,D969,R775,U279,R671,D423,R838,U907,L486,D702,L432,D625,R463,U559,R12,D531,R510,D347,R147,U949,R175,U160,L975,D627,L537,D343,L406,D237,R953,U725,L996,D740,L703,D996,R157,U356,R247,D541,L592,D345,R580,U656,R50,D423,L158,U502,L86,U729,L720,D464,R901,D739,L20,U21,R497,D14,L580,U610,L114,D858,R853,U550,L354,D433,L507,U144,R9,U422,R674,U604,R107,D999,L420,U675,R538,D491,R84,D158,R303,D450,L616,U938,L162,U102,L160,U275,L281,D164,L254,U103,R60,D707,R655,U128,L907,U225,L292,U919,R517,D276,R308,D113,L455,U584,R899,U321,L417,U449,L780,U387,L579,U224,L192,D325,L626,U145,R178,D162,L18,D469,R169,U694,R162,D806,L10,U979,L944,D304,R719,D253,L343,D711,R429,D933,R445,D772,R230,D407,R335,U883,L900,D377,R413,D44,R805,D378,R421,D860,L597,U63,L583,D561,R235,D502,L37,U29,L381,U803,R588,D972,R678,D223,L440,U835,R88,D16,R529,D867,R742,U25,R353,D952,R31,D202,R737,D744,R765,U154,L969,U851,L22,U165,L12,D457,R635,U829,L996,D871,L397,U995,R215,D505,R93,U12,R183,D920,L442,D393,L919,D803,R22,D806,R776,U558,R263,D222,R111,D530,L908,D640,R351,D172,R315,U731,R25,U718,L172,D145,L606,U803,R837,U310,L607,D523,R271,U927,R3,U518,R754,D322,L924,D256,L997,U153,L904,D745,L475,U346,L979,D658,R208,U924,L484,U961,R94,D283,L79,U927,R122,D513,L806,D480,L971,U340,R328,D427,L494",
        "L998,U308,R889,D471,R719,U326,L6,U802,L608,U149,R454,U6,R837,U255,L720,D60,L426,D525,L190,U995,R676,U172,R910,U645,R249,D725,R355,U668,L988,U253,L820,D266,R836,D750,R998,U113,L502,U634,L620,U903,L542,D426,L497,D766,R930,U415,R655,D676,L694,D548,L280,U895,L899,U235,R912,D257,R161,D834,R88,D379,L723,U508,L604,D1,R706,D321,R725,U986,R52,D741,L738,D810,R595,U352,L835,D712,R797,D332,L451,D145,L608,U940,R886,D945,R929,D4,R332,D303,L877,D927,R686,U762,L588,D496,R352,D516,R355,D299,L459,D831,R9,U322,R635,U895,L127,U27,R996,D491,L360,U921,L146,U833,L420,D60,R32,D936,R815,D451,R715,U570,R889,D35,R135,U814,L559,D141,L470,U410,L711,D668,L196,U42,R989,U448,L875,U417,R554,U61,R259,D111,L177,D147,L925,D427,R911,U667,L209,U641,L516,U521,R373,D165,L91,U594,R968,U536,L694,U270,R602,U92,L158,U321,R422,D851,L73,D492,L698,D950,L988,U48,L184,D99,R67,D168,R269,D918,L645,D736,L597,U104,L427,U72,R568,D749,R16,U190,L146,D911,L820,D275,R12,U402,R461,D595,L103,D326,R948,U288,L1,D786,R698,D286,L557,U283,R278,U327,R457,D136,L878,D23,L371,U836,R987,U695,R904,U395,R869,U276,R310,D843,L994,D209,R554,U653,L924,U659,R695,U779,L427,U504,R711,D679,R191,D775,R816,D293,L415,D323,R505,U154,R966,U446,R837,U707,L591,D593,L696,U168,R35,U905,R141,U708,L772,D898,R254,U612,R934,U114,R912,D576,L721,D965,R731,U737,R494,D760,R909,D244,R662,D863,L23,D298,L234,D476,L571,D786,L48,U960,L377,U134,R335,D453,R203,D120,L27,U365,R254,U446,R738,D919,L42,U529,R31,D104,R583,U272,R867,U834,L43,D220,R424"
      )

    IO.puts("The answer is #{answer}") # 403
  end

  @doc """
  Returns the intersection point of two wires, closest to the central port.

  ## Examples

      iex> Day03.closest_intersection_distance("R8,U5,L5,D3", "U7,R6,D4,L4")
      6

  """
  def closest_intersection_distance(wire1, wire2) do
    intersections(wire1, wire2)
    |> Enum.map(&Day03.manhattan_distance/1)
    |> Enum.min()
  end

  @doc """
  Returns all points where two wires intersect.

  ## Examples

      iex> Day03.intersections("R8,U5,L5,D3", "U7,R6,D4,L4")
      [{6, 5}, {3, 3}]

  """
  def intersections(wire1, wire2) do
    route1 = Wire.build(wire1)
    route2 = Wire.build(wire2)

    route1 -- route1 -- route2
  end

  @doc """
  Returns all points where two wires intersect.

  ## Examples

      iex> Day03.manhattan_distance({3, 3})
      6

  """
  def manhattan_distance({x, y}) do
    abs(x) + abs(y)
  end
end

defmodule Wire do
  def build(commands) do
    commands
    |> String.split(",")
    |> Enum.reduce([[{0, 0}]], fn command, acc ->
      [execute_command(command, hd(hd(acc))) | acc]
    end)
    |> List.flatten()
    |> Enum.reverse()
    # remove origin starting point
    |> tl()
  end

  def execute_command(command, starting_point, route \\ [])

  def execute_command("U0", _, route), do: route
  def execute_command("D0", _, route), do: route
  def execute_command("L0", _, route), do: route
  def execute_command("R0", _, route), do: route

  def execute_command("U" <> steps = _command, {x, y} = _starting_point, route) do
    steps = String.to_integer(steps)
    new_point = {x, y + 1}
    execute_command("U#{steps - 1}", new_point, [new_point | route])
  end

  def execute_command("D" <> steps = _command, {x, y} = _starting_point, route) do
    steps = String.to_integer(steps)
    new_point = {x, y - 1}
    execute_command("D#{steps - 1}", new_point, [new_point | route])
  end

  def execute_command("L" <> steps = _command, {x, y} = _starting_point, route) do
    steps = String.to_integer(steps)
    new_point = {x - 1, y}
    execute_command("L#{steps - 1}", new_point, [new_point | route])
  end

  def execute_command("R" <> steps = _command, {x, y} = _starting_point, route) do
    steps = String.to_integer(steps)
    new_point = {x + 1, y}
    execute_command("R#{steps - 1}", new_point, [new_point | route])
  end
end
