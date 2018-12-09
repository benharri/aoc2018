defmodule Day9 do
  def input() do
    input =
      File.stream!("input/day9.in")
      |> Stream.map(&String.trim/1)
      |> Enum.at(0)

    Regex.scan(~r/\d+/, input)
    |> Enum.map(&String.to_integer(hd(&1)))
  end

  def part1() do
    input()
    |> IO.inspect()
  end
end

Day9.part1()
