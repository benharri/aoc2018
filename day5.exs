defmodule Day5 do
  def input() do
    File.stream!("input/day5.in")
    |> Stream.map(&String.trim/1)
    |> Enum.at(0)
  end

  def part1() do
    input()
    |> String.graphemes()
    |> react()
    |> Enum.count()
  end

  def part2() do
    for(n <- ?a..?z, do: <<n::utf8>>)
    |> Enum.map(fn c ->
      input()
      |> String.replace(c, "")
      |> String.replace(String.upcase(c), "")
      |> String.graphemes()
      |> react()
    end)
    |> Enum.min_by(&Enum.count/1)
    |> Enum.count()
  end

  def react(polymer) do
    Enum.reduce(polymer, [], fn
      x, [] ->
        [x]

      x, [y] ->
        [x, y]

      x, [y | ys] ->
        if x != y && String.downcase(x) == String.downcase(y) do
          ys
        else
          [x, y | ys]
        end
    end)
  end
end

IO.puts(Day5.part1())
IO.puts(Day5.part2())
