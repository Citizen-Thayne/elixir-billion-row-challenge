defmodule Formatting do
  def format_integer(int) do
    int
    |> Integer.to_string()
    |> String.split("", trim: true)
    |> Enum.reverse()
    |> Enum.chunk_every(3)
    |> Enum.intersperse("_")
    |> List.flatten()
    |> Enum.reverse()
  end
end
