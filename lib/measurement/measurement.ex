defmodule Measurement do
  def generate(station) do
    {city, avg} = station
    random_temp = avg + :rand.normal(avg, 20)
    "#{city};#{:erlang.float_to_binary(random_temp, decimals: 1)}"
  end

  def from_random(stations) do
    stations
    |> Enum.random()
    |> generate()
  end
end
