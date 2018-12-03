defmodule Day3 do
  def input() do
    File.stream!("input/day3.in")
    |> Stream.map(fn x ->
      Regex.scan(~r/\d+/, x)
      |> Enum.map(&String.to_integer(hd(&1)))
    end)
  end

  def plots(), do: Enum.reduce(input(), %{}, &stake_claim/2)

  def part1() do
    plots()
    |> Enum.count(fn {_k, {v, _}} -> v > 1 end)
  end

  def part2() do
    hd(Enum.find(input(), &intact?(&1, plots())))
  end

  def stake_claim([id, x, y, w, h], claims) do
    coords = for wide <- 0..(w - 1), high <- 0..(h - 1), do: {wide, high}

    Enum.reduce(coords, claims, fn {wide, high}, acc ->
      Map.update(acc, {x + wide, y + high}, {1, [id]}, fn {count, claims} ->
        {count + 1, [id | claims]}
      end)
    end)
  end

  def intact?([id, _x, _y, _w, _h], plot) do
    Enum.all?(plot, fn {_coord, {_count, claims}} ->
      not Enum.member?(claims, id) || claims == [id]
    end)
  end
end

IO.puts(Day3.part1())
IO.puts(Day3.part2())

