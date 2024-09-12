defmodule Benchmark.Iteration do
  @count 100_000

  def run() do
    Benchee.run(
      %{
        "Range + Enum.map_join" => fn -> range_map_join() end,
        "Range + Enum.reduce" => fn -> range_reduce() end,
        "Recursion" => fn -> recursion() end
      },
      profile_after: true
    )
  end

  def range_map_join() do
    1..@count
    |> Enum.map_join("\n", fn _ -> "Fake City;100.0" end)
  end

  def range_reduce() do
    1..@count
    |> Enum.reduce([], fn _, acc -> [acc, "Fake City;100.0\n"] end)
    |> IO.iodata_to_binary()
  end

  defp recursion(), do: recursion(@count, [])
  defp recursion(0, acc), do: acc

  defp recursion(n, acc) do
    recursion(n - 1, [acc, "Fake City;100.0\n"])
    |> IO.iodata_to_binary()
  end
end
