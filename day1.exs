input = File.read!("day1.txt") |> String.split("\n", trim: true)

{left, right} =
  Enum.map(input, &String.split(&1, " ", trim: true))
  |> Enum.map(fn [left, right] ->
    {String.to_integer(String.trim(left)), String.to_integer(String.trim(right))}
  end)
  |> Enum.unzip()

sleft = Enum.sort(left)
sright = Enum.sort(right)
spairs = Enum.zip(sleft, sright)

result =
  Enum.reduce(spairs, 0, fn {left, right}, acc ->
    acc + abs(left - right)
  end)

IO.inspect(result)
