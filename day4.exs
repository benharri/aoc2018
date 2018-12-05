defmodule Day4 do
  def input() do
    File.stream!("input/day4.in")
    |> Stream.map(&String.trim/1)
    |> Enum.sort()
  end

  def part1() do
    {id, minute, _} =
      input()
      |> Enum.map(&parse_record_pattern/1)
      |> Enum.reduce({%{}, [], []}, &stack_and_map/2)
      |> elem(0)
      |> Enum.max_by(fn {_k, v} ->
        v.asleep
        |> Enum.map(&Enum.sum/1)
        |> Enum.sum()
      end)
      |> sleepiest_minute()

    id * minute
  end

  def part2() do
    {id, minute, _count} =
      input()
      |> Enum.map(&parse_record_pattern/1)
      |> Enum.reduce({%{}, [], []}, &stack_and_map/2)
      |> elem(0)
      |> Enum.map(&sleepiest_minute/1)
      |> Enum.max_by(fn {_id, _min, count} -> count end)

    id * minute
  end

  defp sleepiest_minute({id, %{asleep: list_of_ranges}}) do
    {minute, list} =
      list_of_ranges
      |> Enum.flat_map(& &1)
      |> Enum.group_by(& &1)
      |> Enum.max_by(fn {_k, v} -> length(v) end, fn -> {0, []} end)

    {id, minute, length(list)}
  end

  def parse_record_pattern(string) do
    <<
      "[",
      _date::binary-size(10),
      " ",
      _hour::binary-size(2),
      ":",
      minute::binary-size(2),
      "] ",
      action::binary
    >> = string

    %{
      minute: String.to_integer(minute),
      action: parse_action(action)
    }
  end

  defp parse_action("Guard #" <> string) do
    [id] = Regex.run(~r/\d+/, string)
    {:guard, String.to_integer(id)}
  end

  defp parse_action("wakes up"), do: :wake_up
  defp parse_action("falls asleep"), do: :sleep

  def stack_and_map(%{action: {:guard, id}}, {map, awake_stack, asleep_stack}) do
    {Map.put_new(map, id, %{slept: nil, asleep: []}), [id | awake_stack], asleep_stack}
  end

  def stack_and_map(
        %{action: :sleep, minute: minute} = _record,
        {map, [current_id | awake_stack], asleep_stack}
      ) do
    {put_in(map, [current_id, :slept], minute), awake_stack, [current_id | asleep_stack]}
  end

  def stack_and_map(
        %{action: :wake_up, minute: minute} = _record,
        {map, awake_stack, [current_id | asleep_stack]}
      ) do
    went_to_sleep = get_in(map, [current_id, :slept])

    {update_in(map, [current_id, :asleep], &[went_to_sleep..(minute - 1) | &1]),
     [current_id | awake_stack], asleep_stack}
  end
end

IO.puts(Day4.part1())
IO.puts(Day4.part2())
