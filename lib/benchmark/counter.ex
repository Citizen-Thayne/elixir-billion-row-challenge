defmodule Benchmark.Counter do
  def benchmark(opts) do
    file_path = Keyword.get(opts, :file, "measurements.txt")
    profile = Keyword.get(opts, :profile, false)

    IO.puts("Benchmarking line counting of file: #{file_path}")

    Benchee.run(
      %{
        "wc" => fn -> System.cmd("wc", ["-l", file_path]) end,
        "File.stream" => fn -> File.stream!(file_path) |> Enum.count() end
      },
      profile_after: profile
    )

    :ok
  end
end
