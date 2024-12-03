input =
  File.read!("day2.txt")
  |> String.replace("\r", "")
  |> String.split("\n", trim: true)
  |> Enum.map(&String.trim/1)

lines =
  Enum.map(input, fn line ->
    String.split(line)
  end)
  |> Enum.map(fn nums ->
    Enum.map(nums, &Integer.parse/1)
  end)

is_safe = fn line ->
  Enum.reduce_while(0..(length(line) - 2), {nil, true}, fn i, {oper, _} ->
    curr = elem(Enum.at(line, i), 0)
    next = elem(Enum.at(line, i + 1), 0)
    result = curr - next
    this_oper = if result > 0, do: :dec, else: :inc

    cond do
      abs(result) > 3 ->
        {:halt, {this_oper, false}}

      oper == nil ->
        {:cont, {this_oper, true}}

      oper != this_oper ->
        {:halt, {this_oper, false}}

      true ->
        {:cont, {this_oper, true}}
    end
  end)
  |> elem(1)
end

is_safe_less_one = fn line ->
  Enum.any?(0..(length(line) - 1), fn i ->
    reduced_line = List.delete_at(line, i)
    is_safe.(reduced_line)
  end)
end

safes =
  Enum.map(lines, fn line ->
    Enum.reduce_while(0..(length(line) - 2), {nil, true}, fn i, acc ->
      safe = is_safe.(line)

      if safe do
        {:halt, true}
      else
        if is_safe_less_one.(line) do
          {:halt, true}
        else
          {:halt, false}
        end
      end
    end)
  end)
  |> Enum.count(fn e -> e == true end)

IO.inspect(safes)
