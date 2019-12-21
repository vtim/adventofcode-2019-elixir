defmodule Day06 do
  def part1 do
    "input.txt"
    |> File.read!()
    |> OrbitMap.parse()
    |> OrbitMap.orbit_count()
    |> IO.inspect(label: "The checksum is")

    # Output: "The checksum is: 171213"
  end

  def part2 do
    result =
      "input.txt"
      |> File.read!()
      |> OrbitMap.parse()
      |> OrbitMap.count_transfers("YOU", "SAN")

    IO.puts("Number of hops between YOU and SANTA: #{result}")

    # Number of hops between YOU and SANTA: 292
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

  def list_for(map, object, list \\ [])

  def list_for(_map, "COM" = object, list) do
    [object | list]
  end

  def list_for(map, object, list) do
    parent = Map.fetch!(map, object)
    list_for(map, parent, [object | list])
  end

  def count_transfers(map, from, to) do
    from_list = map |> OrbitMap.list_for(from)
    to_list = map |> OrbitMap.list_for(to)

    diff_from = from_list -- to_list
    diff_to = to_list -- from_list

    length(diff_from) + length(diff_to) - 2
  end
end
