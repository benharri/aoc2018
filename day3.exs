defmodule Day3 do
  def input() do
    File.stream!("input/day3.in")
    |> Stream.map(fn x ->
      Regex.scan(~r/\d+/, x)
      |> Enum.map(&String.to_integer(hd(&1)))
    end)
  end

  def fill_grid() do
    # create a 1000x1000 grid
    grid =
      []
      |> List.duplicate(1000)
      |> List.duplicate(1000)

    input()
    |> Enum.reduce(grid, fn [id, x, y, w, h], acc ->
      y..h
      |> Enum.reduce(acc, fn row, grid_row ->
        x..w
        |> Enum.reduce(grid_row, fn col, grid_col ->
          grid_col
          |> List.update_at(row, fn z ->
            IO.puts("row: #{row}, col: #{col}")

            z
            |> List.update_at(col, &[id | &1])
          end)
        end)
      end)
    end)
    |> Enum.reduce(0, fn x, acc ->
      acc + Enum.count(x, &(length(&1) > 1))
    end)
  end
end

# Day3.get_claims()
IO.puts(Day3.fill_grid())
