defmodule Day8 do
  def input() do
    File.stream!("input/day8.in")
    |> Stream.map(&String.trim/1)
    |> Enum.at(0)
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  def part1() do
    input()
    |> IO.inspect()
  end
end

Day8.part1()
