defmodule Day1 do
  @initial_state %{found: [], sum: 0}

  def input() do
    File.stream!("input/day1.in")
    |> Stream.map(&String.to_integer(String.trim(&1)))
  end

  def find_first_repeat(numlist, acc \\ @initial_state) do
    res = find_repeat(numlist, acc)

    find_first_repeat(numlist, res)
  end

  def find_repeat(numlist, acc_init) do
    numlist
    |> Enum.reduce(acc_init, fn x, acc ->
      newval = x + acc.sum

      if newval in acc.found do
        IO.puts("repeated frequency found: #{newval}")
        exit(0)
      end

      %{found: [newval | acc.found], sum: newval}
    end)
  end
end

numlist = Day1.input()
IO.puts(Enum.sum(numlist))
Day1.find_first_repeat(numlist)
