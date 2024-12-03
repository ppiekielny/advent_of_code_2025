defmodule D3 do
  def call(part) do
    {:ok, input} = File.read("lib/aoc/d3/d3.txt")

    if part == 1 do
      part1(input)
    else
      part2(input)
    end
  end

  def part1(input) do
    ~r/mul\((\d{1,3}),(\d{1,3})\)/
    |> Regex.scan(input)
    |> Enum.reduce(0, fn [_, a, b], acc ->
      acc + String.to_integer(a) * String.to_integer(b)
    end)
  end

  def part2(input) do
    ~r/(mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don't\(\))/
    |> Regex.scan(input)
    |> Enum.reduce({0, true}, fn
      ["mul(" <> _, _, a, b], {result, true} ->
        {result + String.to_integer(a) * String.to_integer(b), true}

      ["mul(" <> _, _, _a, _b], {result, false} ->
        {result, false}

      ["do()", _], {result, _} ->
        {result, true}

      ["don't()", _], {result, _} ->
        {result, false}
    end)
    |> elem(0)
  end
end
