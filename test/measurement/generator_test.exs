defmodule Measurement.GeneratorTest do
  use ExUnit.Case

  test "test stream" do
    :rand.seed(:exsplus, {1, 2, 3})
    size = 100

    {:ok, _, file_path} = Temp.open()

    stream = File.stream!(file_path)
    MeasurementGenerator.Generator.into(stream, size)

    lines =
      File.read!(file_path)
      |> String.split("\n", trim: true)

    assert Enum.count(lines) == size

    Enum.each(lines, fn line ->
      parts = String.split(line, ";")
      assert Enum.count(parts) == 2
      [city, temp] = parts
      assert String.valid?(city)
      assert String.to_float(temp)
    end)
  end
end
