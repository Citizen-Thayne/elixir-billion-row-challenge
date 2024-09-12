defmodule Benchmark.Generator do
  def benchmark(opts) do
    with {:ok, opts} <- parse_options(opts),
         opts <- Keyword.update(opts, :chunk_sizes, [1000], &parse_chunk_sizes/1) do
      run(opts)
    end
  end

  def parse_options(opts) do
    case OptionParser.parse(opts,
           switches: [profile: :boolean, count: :integer, chunk_sizes: :string],
           aliases: [n: :count, c: :chunk_sizes, p: :profile]
         ) do
      {opts, _rest, []} -> {:ok, opts}
      {_, _, invalid} -> {:error, "Invalid options: #{inspect(invalid)}"}
    end
  end

  def parse_chunk_sizes(sizes) do
    sizes
    |> String.split(",")
    |> Enum.reduce_while([], fn size, acc ->
      case Integer.parse(size) do
        {size, ""} -> {:cont, [size | acc]}
        _ -> {:halt, {:error, "Invalid chunk size: #{size}"}}
      end
    end)
  end

  def new_stream do
    {:ok, _, file_path} = Temp.open()
    File.stream!(file_path)
  end

  def run(opts) do
    profile = Keyword.get(opts, :profile, false)
    count = Keyword.get(opts, :count, 100_000)
    chunk_sizes = Keyword.fetch!(opts, :chunk_sizes)

    IO.puts("Benchmarking Measurment Generation Strategies")

    runs =
      Enum.reduce(chunk_sizes, %{}, fn chunk_size, acc ->
        name =
          "Generate x#{Formatting.format_integer(count)} Chunk Size: #{Formatting.format_integer(chunk_size)}"

        func = fn -> MeasurementGenerator.Generator.into(new_stream(), count, chunk_size) end
        Map.put(acc, name, func)
      end)

    Benchee.run(
      runs,
      profile_after: profile
    )
  end
end
