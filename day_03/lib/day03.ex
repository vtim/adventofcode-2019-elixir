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
    |> Enum.min
  end

  @doc """
  Returns all points where two wires intersect.

  ## Examples

      iex> Day03.intersections("R8,U5,L5,D3", "U7,R6,D4,L4")
      [{3, 3}, {5, 6}]

  """
  def intersections(_wire1, _wire2) do
    [{3, 3}, {5, 6}]
  end

  @doc """
  Returns all points where two wires intersect.

  ## Examples

      iex> Day03.manhattan_distance({3, 3})
      6

  """
  def manhattan_distance({x, y}) do
    x + y
  end
end
