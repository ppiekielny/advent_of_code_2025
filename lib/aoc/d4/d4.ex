defmodule D4 do
  def call(part) do
    {:ok, input} = File.read("lib/aoc/d4/d4.txt")

    if part == 1 do
      part1(input)
    else
      part2(input)
    end
  end

  def part1(input) do
    # XY
    directions = [
      {-1, -1},
      {0, -1},
      {1, -1},
      {-1, 0},
      {1, 0},
      {-1, 1},
      {0, 1},
      {1, 1}
    ]

    matrix =
      input
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)

    Enum.reduce(0..(length(matrix) - 1), 0, fn y, acc ->
      Enum.reduce(0..(length(List.first(matrix)) - 1), 0, fn x, row_acc ->
        char_sum =
          if at(matrix, x, y) == "X" do
            Enum.reduce(directions, 0, fn {dx, dy}, char_acc ->
              with "M" <- at(matrix, x + dx, y + dy),
                   "A" <- at(matrix, x + 2 * dx, y + 2 * dy),
                   "S" <- at(matrix, x + 3 * dx, y + 3 * dy) do
                char_acc + 1
              else
                _ ->
                  char_acc
              end
            end)
          else
            0
          end

        row_acc + char_sum
      end) + acc
    end)
  end

  defp at(matrix, x, y) do
    if x < 0 or y < 0 do
      nil
    else
      if row = Enum.at(matrix, y) do
        Enum.at(row, x)
      end
    end
  end

  def part2(input) do
    matrix =
      input
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)

    Enum.reduce(0..(length(matrix) - 1), 0, fn y, acc ->
      Enum.reduce(0..(length(List.first(matrix)) - 1), 0, fn x, row_acc ->
        if at(matrix, x, y) == "A" and
             Enum.sort([at(matrix, x - 1, y - 1), at(matrix, x + 1, y + 1)]) == ["M", "S"] and
             Enum.sort([at(matrix, x + 1, y - 1), at(matrix, x - 1, y + 1)]) == ["M", "S"] do
          row_acc + 1
        else
          row_acc
        end
      end) + acc
    end)
  end
end
