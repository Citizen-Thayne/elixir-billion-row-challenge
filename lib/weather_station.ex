defmodule WeatherStation do
  def parse(line) do
    [city, avg | _] = String.split(line, [";", "\n"])
    {temp, _} = Float.parse(avg)
    {city, temp}
  end

  def load do
    File.read!("weather_stations.csv")
    |> String.split("\n")
    |> Enum.filter(fn line -> String.length(line) > 0 end)
    |> Enum.map(&parse/1)
  end
end
