defmodule Measurement.Average do
  def average_measurements(measurements, mode \\ :simple, chunk_size \\ 1_000)

  def average_measurements(measurements, :batch, chunk_size) do
    measurements
    |> Stream.chunk_every(chunk_size)
    |> Task.async_stream(&average_chunk/1, ordered: false)
    |> Enum.reduce(%{}, fn {:ok, chunk_count_sum}, acc ->
      Map.merge(acc, chunk_count_sum, fn _k, {sum1, count1}, {sum2, count2} ->
        {sum1 + sum2, count1 + count2}
      end)
    end)
    |> Enum.map(fn {city, {temp_sum, count}} -> {city, temp_sum / count} end)
    |> Map.new()
  end

  def average_measurements(measurements, :simple, _) do
    measurements
    |> Enum.reduce(%{}, fn line, acc ->
      {city, temp1} = WeatherStation.parse(line)

      Map.update(acc, city, {temp1, 1}, fn {temp, count} ->
        {temp + temp1, count + 1}
      end)
    end)
    |> Enum.map(fn {city, {temp_sum, count}} -> {city, temp_sum / count} end)
    |> Map.new()
  end

  defp average_chunk(chunk) do
    chunk
    |> Enum.reduce(%{}, fn line, acc ->
      [city, temp_string] = String.split(line, ";")
      {temp1, _} = Float.parse(temp_string)

      Map.update(acc, city, {temp1, 1}, fn {temp, count} ->
        {temp + temp1, count + 1}
      end)
    end)
  end
end
