defmodule Day06 do
  def part1 do
    "input.txt"
    |> File.read!
    |> OrbitMap.parse()
    |> OrbitMap.orbit_count()
    |> IO.inspect(label: "The checksum is")

    # Output: "The checksum is: 171213"
  end
end

defmodule OrbitMap do
  @doc """
  Parses map data into a Map

  ## Examples

  iex> OrbitMap.parse("COM)B")
  %{ "B" => "COM" }
  """
  def parse(map_data) do
    map_data
    |> String.split("\n")
    |> Enum.reduce(%{}, fn x, acc ->
      case String.split(x, ")") do
        [around, planet] -> Map.put(acc, planet, around)
        _ -> acc
      end
    end)
  end

  @doc """
  Calculates the total number of direct and indirect orbits.

  ## Examples

  iex> OrbitMap.orbit_count(%{"B" => "COM", "C" => "B"})
  3
  """
  def orbit_count(map) do
    map
    |> Map.keys()
    |> Enum.reduce(0, fn x, acc -> acc + traverse(map, x) end)
  end

  defp traverse(map, x, level \\ 0) do
    # IO.puts("traverse #{x}, level=#{level}")
    case parent = Map.fetch!(map, x) do
      "COM" -> level + 1
      _ -> traverse(map, parent, level + 1)
    end
  end
end
