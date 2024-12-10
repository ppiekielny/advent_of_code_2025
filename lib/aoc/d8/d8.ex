defmodule D8 do
  def call(part) do
    {:ok, input} = File.read("lib/aoc/d8/d8.txt")

    if part == 1 do
      part1(input)
    else
      part2(input)
    end
  end

  def part1(input) do
    {antennas, width, height} = parse_input(input)

    antennas
    |> Enum.map(fn {_type, locations} -> get_antinodes(locations, [1]) end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.filter(&valid_location?(width, height, &1))
    |> Enum.count()
  end

  def part2(input) do
    {antennas, width, height} = parse_input(input)

    max_dist = max(width, height)

    antennas
    |> Enum.map(fn {_type, locations} -> get_antinodes(locations, 0..max_dist) end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.filter(&valid_location?(width, height, &1))
    |> Enum.count()
  end

  # defp debug_draw(antinodes, width, height) do
  #   for y <- 0..(height - 1) do
  #     for x <- 0..(width - 1) do
  #       cond do
  #         Enum.member?(antinodes, {x, y}) -> "X"
  #         true -> "."
  #       end
  #     end
  #     |> Enum.join()
  #   end
  #   |> IO.inspect(width: 12)

  #   antinodes
  # end

  defp get_antinodes(locations, steps) do
    for {x1, y1} <- locations, {x2, y2} <- locations, {x1, y1} != {x2, y2}, step <- steps do
      {x2 + step * (x2 - x1), y2 + step * (y2 - y1)}
    end
  end

  defp valid_location?(width, height, {x, y}) do
    x >= 0 and x < width and y >= 0 and y < height
  end

  defp parse_input(input) do
    input
    |> String.graphemes()
    |> Enum.reduce({%{}, 0, 0}, fn char, {acc, x, y} ->
      case char do
        "\n" ->
          {acc, 0, y + 1}

        "." ->
          {acc, x + 1, y}

        char ->
          acc =
            Map.update(acc, char, [{x, y}], fn locations ->
              [{x, y} | locations]
            end)

          {acc, x + 1, y}
      end
    end)
    |> then(fn {acc, width, height} -> {acc, width, height + 1} end)
  end
end
