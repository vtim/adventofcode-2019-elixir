defmodule Day03 do
  @moduledoc """
  Documentation for Day03.
  """

  @doc """
  Returns the intersection point of two wires, closest to the central port.

  ## Examples

      iex> Day03.closest_cross_distance("R8,U5,L5,D3", "U7,R6,D4,L4")
      6

  """
  def closest_cross_distance(wire1, wire2) do
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

    route1 -- (route1 -- route2)
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
    |> tl() # remove origin starting point
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
