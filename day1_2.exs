input = File.read!("day1.txt") |> String.split("\n", trim: true)

{left, right} =
  Enum.map(input, &String.split(&1, " ", trim: true))
  |> Enum.map(fn [left, right] ->
    {String.to_integer(String.trim(left)), String.to_integer(String.trim(right))}
  end)
  |> Enum.unzip()

result =
  Enum.zip(left, right)
  |> Enum.reduce(0, fn {l, _}, acc ->
    count = Enum.count(right, fn x -> x == l end)
    acc + l * count
  end)

IO.inspect(result)
