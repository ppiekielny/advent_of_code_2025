defmodule D1 do
  def call(part) do
    {:ok, input} = File.read("lib/aoc/d1/d1.txt")

    if part == 1 do
      part1(input)
    else
      part2(input)
    end
  end

  def part1(input) do
    String.split(input, "\n")
    |> Enum.reduce({[], []}, fn row, {acc1, acc2} ->
      [col1, col2] =
        row
        |> String.split("   ")
        |> Enum.map(&String.to_integer/1)

      {[col1 | acc1], [col2 | acc2]}
    end)
    |> then(fn {list1, list2} ->
      Enum.zip(Enum.sort(list1), Enum.sort(list2))
    end)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def part2(input) do
    {list1, list2} =
      String.split(input, "\n")
      |> Enum.reduce({[], []}, fn row, {acc1, acc2} ->
        [col1, col2] =
          row
          |> String.split("   ")
          |> Enum.map(&String.to_integer/1)

        {[col1 | acc1], [col2 | acc2]}
      end)

    list1
    |> Enum.map(fn x ->
      x * Enum.count(list2, &(&1 == x))
    end)
    |> Enum.sum()
  end
end
