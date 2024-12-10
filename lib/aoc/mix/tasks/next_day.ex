defmodule Mix.Tasks.NextDay do
  use Mix.Task

  @shortdoc "Create a new day"
  def run([day]) do
    app_dir = File.cwd!()
    app_name = Path.basename(app_dir)
    new_file_path = Path.join([app_dir, "lib", app_name, "d#{day}", "d#{day}.ex"])

    File.write(
      new_file_path,
      """
      defmodule D#{day} do
        def call(part) do
          {:ok, input} = File.read("lib/aoc/d#{day}/d#{day}.txt")

          if part == 1 do
            part1(input)
          else
            part2(input)
          end
        end

        def part1(input) do
          input
        end

        def part2(input) do
          input
        end
      end
      """,
      [:write]
    )

    new_test_file_path = Path.join([app_dir, "lib", app_name, "d#{day}", "d#{day}.test.exs"])

    File.write(
      new_test_file_path,
      """
      defmodule D#{day}Test do
        use ExUnit.Case, async: true

        test "part1" do
          input = ""

          assert D7.part1(input) == 3749
        end

        test "part2" do
          input = ""

          assert D7.part2(input) == 11387
        end
      end
      """,
      [:write]
    )

    new_input_file_path = Path.join([app_dir, "lib", app_name, "d#{day}", "d#{day}.txt"])

    File.write(new_input_file_path, "", [:write])
  end
end
