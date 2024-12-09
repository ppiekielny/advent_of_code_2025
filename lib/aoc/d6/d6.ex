defmodule D6 do
  @dirs %{
    0 => {0, -1},
    1 => {1, 0},
    2 => {0, 1},
    3 => {-1, 0}
  }

  def call(part) do
    {:ok, input} = File.read("lib/aoc/d6/d6.txt")

    if part == 1 do
      part1(input)
    else
      part2(input)
    end
  end

  def part1(input) do
    {map, width, height} = parse_map(input)

    guard_loc = Enum.find(map, fn {_loc, char} -> char == "^" end) |> elem(0)

    map = Map.put(map, guard_loc, "x")

    end_map = move1(map, guard_loc, width, height)

    Enum.count(end_map, fn {_loc, char} -> char == "x" end)
  end

  defp move1(map, {x, y}, width, height, dir \\ 0) do
    next_loc = {x + elem(@dirs[dir], 0), y + elem(@dirs[dir], 1)}

    case map[next_loc] do
      nil -> map
      "." -> move1(Map.put(map, next_loc, "x"), next_loc, width, height, dir)
      "x" -> move1(map, next_loc, width, height, dir)
      "#" -> move1(map, {x, y}, width, height, rem(dir + 1, 4))
    end
  end

  def part2(input) do
    {map, width, height} = parse_map(input)

    guard_loc = Enum.find(map, fn {_loc, char} -> char == "^" end) |> elem(0)

    possible_obstacles =
      Enum.filter(map, fn {_loc, char} -> char == "." end) |> Enum.map(&elem(&1, 0))

    map = Map.put(map, guard_loc, ".")

    possibles_count = length(possible_obstacles)

    Enum.reduce(possible_obstacles, {0, 0}, fn obstacle, {i, acc} ->
      IO.inspect("#{i}/#{possibles_count}")
      map = Map.put(map, obstacle, "#")

      if guard_prisoned?(map, guard_loc, width, height) do
        {i + 1, acc + 1}
      else
        {i + 1, acc}
      end
    end)
    |> elem(1)
  end

  # obstacle hits are map {obstacle_loc => [hit_direction]} If the obstacle is hit twice from the same direction it's prisoned
  defp guard_prisoned?(map, {x, y}, width, height, dir \\ 0, obstacle_hits \\ %{}) do
    next_loc = {x + elem(@dirs[dir], 0), y + elem(@dirs[dir], 1)}

    case map[next_loc] do
      nil ->
        false

      "." ->
        guard_prisoned?(map, next_loc, width, height, dir, obstacle_hits)

      "#" ->
        hits_directions = Map.get(obstacle_hits, next_loc, [])

        if dir in hits_directions do
          true
        else
          guard_prisoned?(
            map,
            {x, y},
            width,
            height,
            rem(dir + 1, 4),
            Map.put(obstacle_hits, next_loc, [dir | hits_directions])
          )
        end
    end
  end

  def parse_map(input) do
    Enum.reduce(String.graphemes(input), {%{}, 0, 0}, fn char, {acc, x, y} ->
      case char do
        "\n" ->
          {acc, 0, y + 1}

        char ->
          {Map.put(acc, {x, y}, char), x + 1, y}
      end
    end)
  end
end
