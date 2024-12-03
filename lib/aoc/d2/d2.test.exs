defmodule D2Test do
  use ExUnit.Case

  test "part1" do
    input = "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

    assert D2.part1(input) == 2
  end

  test "part2" do
    input = "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9"

    assert D2.part2(input) == 4
  end

  test "is_safe?" do
    assert D2.is_safe?([1, 3, 4, 5]) == true
    assert D2.is_safe?([5, 4, 3, 1]) == true
    # equal adjacents
    assert D2.is_safe?([1, 1, 2, 3]) == false
    # different order
    assert D2.is_safe?([1, 2, 4, 2]) == false
    # difference greater than 3
    assert D2.is_safe?([1, 5, 7, 8]) == false
  end
end
