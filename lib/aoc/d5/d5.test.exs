defmodule D5Test do
  use ExUnit.Case

  setup do
    rules = "47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13"

    updates = "75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47"

    {:ok, rules: rules, updates: updates}
  end

  test "part1", %{rules: rules, updates: updates} do
    assert D5.part1(rules, updates) == 143
  end

  test "part2", %{rules: rules, updates: updates} do
    assert D5.part2(rules, updates) == 123
  end

  test "fix_update", %{rules: rules} do
    rules = D5.parse_rules(rules)

    assert D5.fix_update([75, 97, 47, 61, 53], rules) == [97, 75, 47, 61, 53]
    assert D5.fix_update([61, 13, 29], rules) == [61, 29, 13]
    assert D5.fix_update([97, 13, 75, 29, 47], rules) == [97, 75, 47, 29, 13]
  end
end
