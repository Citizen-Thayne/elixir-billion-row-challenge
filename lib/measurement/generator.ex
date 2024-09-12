defmodule MeasurementGenerator.Generator do
  def into(stream, count, chunk_size \\ 1000) do
    stations = WeatherStation.load()

    1..count
    |> Enum.chunk_every(chunk_size)
    |> Task.async_stream(fn chunk ->
      Enum.map_join(chunk, "\n", fn _ -> Measurement.from_random(stations) end)
    end)
    |> Stream.map(fn {:ok, measurements} -> measurements end)
    |> Stream.into(stream)
    |> Stream.run()
  end
end
