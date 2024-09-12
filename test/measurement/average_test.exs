defmodule Measurement.AverageTest do
  use ExUnit.Case

  describe "average_measurements" do
    test "empty" do
      assert Measurement.Average.average_measurements([], :simple) == %{}
      assert Measurement.Average.average_measurements([], :batch) == %{}
    end

    test "Single measurement" do
      assert Measurement.Average.average_measurements(["foo;100\n"], :simple) == %{"foo" => 100.0}
      assert Measurement.Average.average_measurements(["foo;100\n"], :batch) == %{"foo" => 100.0}
    end

    test "Multiple Cities" do
      assert Measurement.Average.average_measurements(["foo;100\n", "bar;200\n"], :simple) == %{
               "foo" => 100.0,
               "bar" => 200.0
             }

      assert Measurement.Average.average_measurements(["foo;100\n", "bar;200\n"], :batch) == %{
               "foo" => 100.0,
               "bar" => 200.0
             }
    end

    test "Same city" do
      assert Measurement.Average.average_measurements(["foo;100\n", "foo;200\n"], :simple) == %{
               "foo" => 150.0
             }

      assert Measurement.Average.average_measurements(["foo;100\n", "foo;200\n"], :batch) == %{
               "foo" => 150.0
             }
    end
  end
end
