File.stream!("day1.in")
|> Stream.map(fn x ->
  x |> String.trim() |> String.replace_leading("+", "") |> String.to_integer()
end)
|> Enum.sum()
|> IO.puts()

