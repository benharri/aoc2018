defmodule Day6 do
  @margin 2

  def input() do
    File.stream!("input/day6.in")
    |> Enum.map(fn x ->
      x
      |> String.split(", ")
      |> Enum.map(&String.to_integer(String.trim(&1)))
    end)
  end

  def part1() do
    {xmin, xmax} = Enum.map(input(), &hd/1) |> Enum.min_max()
    {ymin, ymax} = Enum.map(input(), &tl/1) |> Enum.min_max()

    input()
    |> IO.inspect(label: "xmin: #{xmin}, xmax: #{xmax}, ymin: #{ymin}, ymax: #{ymax}")
  end
end

Day6.part1()
