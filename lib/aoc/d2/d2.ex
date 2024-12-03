defmodule D2 do
  def call(part) do
    {:ok, input} = File.read("lib/aoc/d2/d2.txt")

    if part == 1 do
      part1(input)
    else
      part2(input)
    end
  end

  def part1(input) do
    input
    |> parse_input()
    |> Enum.filter(&is_safe?/1)
    |> Enum.count()
  end

  def part2(input) do
    input
    |> parse_input()
    |> Enum.filter(fn row ->
      if is_safe?(row) do
        true
      else
        Enum.reduce_while(0..length(row), false, fn i, _ ->
          {_, new_row} = List.pop_at(row, i)

          if is_safe?(new_row) do
            {:halt, true}
          else
            {:cont, false}
          end
        end)
      end
    end)
    |> Enum.count()
  end

  def is_safe?(row) do
    Enum.chunk_every(row, 2, 1, :discard)
    |> Enum.reduce_while({nil, true}, fn [a, b], {order, _is_safe?} ->
      result = a - b

      if result == 0 or abs(result) > 3 do
        {:halt, {nil, false}}
      else
        new_order = get_order(result)

        case order do
          nil ->
            {:cont, {new_order, true}}

          order ->
            if order != new_order do
              {:halt, {nil, false}}
            else
              {:cont, {order, true}}
            end
        end
      end
    end)
    |> elem(1)
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  # Returns the order of the two numbers in the row.
  @spec get_order(integer()) :: :asc | :desc
  defp get_order(result) when result > 0, do: :desc
  defp get_order(result) when result < 0, do: :asc
end
