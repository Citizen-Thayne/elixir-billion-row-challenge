defmodule Benchmark.Average do
  def benchmark do
    benchmark_simple_vs_batch()
    benchmark_read_ahead()
    benchmark_chunk_size()
  end

  defp benchmark_simple_vs_batch do
    Benchee.run(
      %{
        "Simple" => fn -> run(:simple) end,
        "Batch" => fn -> run(2 ** 16, 2 ** 17) end
      },
      profile_after: false
    )
  end

  defp benchmark_read_ahead do
    Benchee.run(
      %{
        "Read ahead: 32_000" => fn -> run(32_000, 2 ** 17) end,
        "Read ahead: 50_000" => fn -> run(50_000, 2 ** 17) end,
        "Read ahead: 64_000" => fn -> run(64_000, 2 ** 17) end,
        "Read ahead: 2^16" => fn -> run(2 ** 16, 2 ** 17) end,
        "Read ahead: 100_000" => fn -> run(100_000, 2 ** 17) end
      },
      profile_after: false
    )
  end

  defp benchmark_chunk_size do
    Benchee.run(
      %{
        "Chunk size: 2^16" => fn -> run(2 ** 16, 2 ** 16) end,
        "Chunk size: 2^17" => fn -> run(2 ** 16, 2 ** 17) end,
        "Chunk size: 2^18" => fn -> run(2 ** 16, 2 ** 18) end,
        "Chunk size: 2^19" => fn -> run(2 ** 16, 2 ** 19) end
      },
      profile_after: false
    )
  end

  def run(:simple) do
    stream = File.stream!("measurements.txt")

    Measurement.Average.average_measurements(stream, :simple)
  end

  defp run(read_ahead_length, chunk_size) do
    stream = File.stream!("measurements.txt", [{:read_ahead, read_ahead_length}])

    Measurement.Average.average_measurements(stream, :batch, chunk_size)
  end
end

Benchmark.Average.benchmark()
