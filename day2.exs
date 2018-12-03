defmodule Day2 do
  def input() do
    File.stream!("input/day2.in")
    |> Stream.map(&String.trim/1)
  end

  def find_subcount(count) do
    input()
    |> Enum.reduce(0, fn x, acc ->
      if x
         |> String.graphemes()
         |> Enum.sort()
         |> Enum.uniq()
         |> Enum.any?(fn y ->
           Enum.count(String.graphemes(x), &(&1 == y)) == count
         end) do
        acc + 1
      else
        acc
      end
    end)
  end

  def find_common_chars() do
    input()
    |> Enum.reduce(%MapSet{}, fn x, acc ->
      x
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {_c, i}, seen ->
        pair = {i, String.slice(x, 0, i) <> String.slice(x, (i + 1)..-1)}
        if MapSet.member?(seen, pair), do: IO.puts(elem(pair, 1))
        MapSet.put(seen, pair)
      end)
    end)
  end
end

IO.puts(Day2.find_subcount(2) * Day2.find_subcount(3))
Day2.find_common_chars()
