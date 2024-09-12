defmodule MeasurementTest do
  use ExUnit.Case

  test "generate" do
    station = {"Berlin", 20.0}
    result = Measurement.generate(station)
    assert String.contains?(result, "Berlin;")
  end

  test "from_random" do
    stations = [{"Berlin", 20.0}, {"Los Angeles", 34.1141}]
    result = Measurement.from_random(stations)
    assert String.contains?(result, "Berlin;") or String.contains?(result, "Los Angeles;")
  end
end
