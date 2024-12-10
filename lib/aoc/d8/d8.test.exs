defmodule D8Test do
  use ExUnit.Case, async: true

  test "part1" do
    input = "............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............"

    assert D8.part1(input) == 14
  end

  test "part2" do
    input = "............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............"

    assert D8.part2(input) == 34
  end
end