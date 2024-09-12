defmodule Mix.Tasks.CreateMeasurements do
  use Mix.Task

  def run([file_path, count]) do
    parsed_count = String.to_integer(count)
    File.touch!(file_path)
    IO.puts("Counting measurements in #{file_path}...")
    current_count = File.stream!(file_path) |> Enum.count()
    generate_count = parsed_count - current_count

    IO.puts("Creating #{Formatting.format_integer(generate_count)} measurements in #{file_path}")

    stream = File.stream!(file_path, [:write, :utf8, :append, :delayed_write])

    time = System.system_time(:second)
    MeasurementGenerator.Generator.into(stream, generate_count)

    IO.puts("Done!")
    IO.puts("Time: #{System.system_time(:second) - time} seconds")
  end
end
