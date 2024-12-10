defmodule D7 do
  def call(part) do
    {:ok, input} = File.read("lib/aoc/d7/d7.txt")

    if part == 1 do
      part1(input)
    else
      part2(input)
    end
  end

  def part1(input) do
    parsed_input = parse_input(input)

    Enum.filter(parsed_input, fn {result, values} ->
      [first | rest] = values

      results =
        calculate(rest, first)
        |> List.flatten()

      Enum.any?(results, &(&1 == result))
    end)
    |> Enum.reduce(0, fn {result, _values}, acc -> acc + result end)
  end

  def calculate(values, result) do
    if values == [] do
      result
    else
      [value | rest] = values

      [
        calculate(rest, value + result),
        calculate(rest, value * result)
      ]
    end
  end

  def part2(input) do
    parsed_input = parse_input(input)

    Enum.filter(parsed_input, fn {result, values} ->
      [first | rest] = values

      results =
        calculate2(rest, first)
        |> List.flatten()

      Enum.any?(results, &(&1 == result))
    end)
    |> Enum.reduce(0, fn {result, _values}, acc -> acc + result end)
  end

  def calculate2(values, result) do
    if values == [] do
      result
    else
      [value | rest] = values

      [
        calculate2(rest, value + result),
        calculate2(rest, value * result),
        calculate2(rest, String.to_integer("#{result}#{value}"))
      ]
    end
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ": "))
    |> Enum.map(fn [result, values] ->
      {String.to_integer(result),
       String.split(values, " ", trim: true) |> Enum.map(&String.to_integer/1)}
    end)
  end
end
