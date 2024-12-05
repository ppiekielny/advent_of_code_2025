defmodule D5 do
  def call(part) do
    {:ok, rules} = File.read("lib/aoc/d5/rules.txt")
    {:ok, updates} = File.read("lib/aoc/d5/updates.txt")

    if part == 1 do
      part1(rules, updates)
    else
      part2(rules, updates)
    end
  end

  def part1(rules, updates) do
    rules =
      rules
      |> parse_rules()
      |> Enum.group_by(&List.first(&1), &List.last(&1))

    updates = parse_updates(updates)

    Enum.reduce(updates, 0, fn update, acc ->
      if is_valid?(update, rules) do
        update
        |> Enum.at(trunc(length(update) / 2))
        |> Kernel.+(acc)
      else
        acc
      end
    end)
  end

  def part2(rules, updates) do
    rules = parse_rules(rules)
    grouped_rules = Enum.group_by(rules, &List.first(&1), &List.last(&1))

    updates = parse_updates(updates)

    Enum.reduce(updates, 0, fn update, acc ->
      if not is_valid?(update, grouped_rules) do
        fixed_update = fix_update(update, rules)

        fixed_update
        |> Enum.at(trunc(length(update) / 2))
        |> Kernel.+(acc)
      else
        acc
      end
    end)
  end

  def is_valid?(update, rules) do
    Enum.reduce_while(update, {update, true}, fn _, {list, is_valid?} ->
      if length(list) == 1 do
        {:halt, {list, is_valid?}}
      else
        [value | rest] = list

        invalid_value? =
          Enum.any?(rest, fn next_value ->
            rules[next_value] && value in rules[next_value]
          end)

        if invalid_value? do
          {:halt, {list, false}}
        else
          {:cont, {rest, true}}
        end
      end
    end)
    |> elem(1)
  end

  def parse_rules(rules) do
    rules
    |> String.split("\n")
    |> Enum.map(fn row -> String.split(row, "|") |> Enum.map(&String.to_integer/1) end)
  end

  def parse_updates(updates) do
    updates
    |> String.split("\n")
    |> Enum.map(fn row -> String.split(row, ",") |> Enum.map(&String.to_integer/1) end)
  end

  def fix_update(update, rules) do
    Enum.sort(update, fn a, b ->
      case Enum.find(rules, fn [x, y] -> (x == a and y == b) or (x == b and y == a) end) do
        [^a, ^b] -> true
        [^b, ^a] -> false
        nil -> a < b
      end
    end)
  end
end
