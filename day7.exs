defmodule Day7 do
  def input() do
    File.stream!("input/day7.in")
    |> Enum.map(fn x ->
      Regex.scan(~r/[A-Z]/, x)
      |> Enum.drop(1)
      |> Enum.map(&hd/1)
    end)
  end

  def part1() do
    input()
    |> IO.inspect()
    |> work(1, -30)
    |> Enum.at(0)
  end

  def part2() do
    input()
    |> work(5, 61)
    |> Enum.at(1)
  end

  def work(deps, paral, factor) do
    remaining =
      deps
      |> flatten()
      |> Enum.uniq()

    doable = fn ->
      remaining
      |> Enum.find(fn x ->
        !Enum.any?(fn _, y -> y == x)
      end)
      |> Enum.min()
    end

    goal = length(remaining)
    done = ""
    workers = List.duplicate(nil, paral)

    Enum.reduce_while(deps, [], fn t, acc ->

    end)
  end

  def flatten(list), do: flatten(list, []) |> Enum.reverse()
  def flatten([h | t], acc) when h == [], do: flatten(t, acc)
  def flatten([h | t], acc) when is_list(h), do: flatten(t, flatten(h, acc))
  def flatten([h | t], acc), do: flatten(t, [h | acc])
  def flatten([], acc), do: acc
end

IO.puts(Day7.part1())
IO.puts(Day7.part2())
