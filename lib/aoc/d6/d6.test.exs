defmodule D6Test do
  use ExUnit.Case, async: true

  test "part1" do
    input = "....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#..."

    assert D6.part1(input) == 41
  end

  test "part2" do
    input = "....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#..."

    assert D6.part2(input) == 6
  end
end