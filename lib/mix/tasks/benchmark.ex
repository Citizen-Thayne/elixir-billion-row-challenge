defmodule Mix.Tasks.Benchmark do
  use Mix.Task

  def run([]), do: IO.puts(:stderr, "No benchmark name provided")

  def run([benchmark_name | opts]) do
    case run_benchmark(benchmark_name, opts) do
      {:error, msg} -> IO.puts(:stderr, msg)
      _ -> IO.puts("Done")
    end

    nil
  end

  def run_benchmark(benchmark_name, opts) do
    case benchmark_name do
      "generator" -> Benchmark.Generator.benchmark(opts)
      "counter" -> Benchmark.Counter.benchmark(opts)
      _ -> {:error, "Unknown benchmark \"#{benchmark_name}\""}
    end
  end
end
