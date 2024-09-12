defmodule WeatherStationTest do
  use ExUnit.Case

  test "parse" do
    line = "Berlin;20"
    result = WeatherStation.parse(line)
    assert result == {"Berlin", 20.0}

    line = "Berlin;20.0"
    result = WeatherStation.parse(line)
    assert result == {"Berlin", 20.0}

    line = "Berlin;20.0\n"
    result = WeatherStation.parse(line)
    assert result == {"Berlin", 20.0}
  end

  test "load" do
    stations = WeatherStation.load()
    assert length(stations) == 44691
    assert Enum.member?(stations, {"Los Angeles", 34.1141})
  end
end
