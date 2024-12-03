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

safes =
  Enum.map(lines, fn line ->
    Enum.reduce_while(0..(length(line) - 2), {nil, true}, fn i, acc ->
      curr = Enum.at(line, i)
      next = Enum.at(line, i + 1)
      oper = elem(acc, 0)
      result = elem(curr, 0) - elem(next, 0)
      this_oper = if result > 0, do: :inc, else: :dec
      #IO.inspect(curr)
      #IO.inspect(next)
      #IO.inspect(oper)
      #IO.inspect(result)
      #IO.inspect(this_oper)

      cond do
        abs(result) > 3 ->
          #IO.puts("Result too big")
          {:halt, {this_oper, false}}
        
        abs(result) < 1 ->
          #IO.puts("Result too small")
          {:halt, {this_oper, false}}
          
        oper == nil ->
          {:cont, {this_oper, true}}

        oper != this_oper ->
          #IO.puts("Operation changed")
          {:halt, {this_oper, false}}

        true ->
          {:cont, {this_oper, true}}
      end
    end)
  end)
  |> Enum.count(fn {_, valid?} -> valid? end)

IO.inspect(safes)
