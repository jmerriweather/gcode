defmodule Gcode.Machine.Sanitising do
  @moduledoc """
  Functions for when we are in the sanitising state
  """
  require Logger

  def sanitising(:internal, {:sanitise, decompressed}, data) do
    sanitised_gcode =
      String.split(decompressed, ~r/\R/)
      # remove lines starting with a comment
      |> Stream.reject(&String.starts_with?(&1, [";"]))
      # remove comments from the end of lines
      |> Stream.map(&(String.split(&1, ";") |> hd()))
      # remove any excess whitespace
      |> Stream.map(&String.trim(&1))
      # removed empty strings
      |> Stream.reject(&(&1 == ""))
      # make stream into a list
      |> Enum.to_list()

    {:next_state, :parsing, data, [{:next_event, :internal, {:parse, sanitised_gcode}}]}
  end

  def sanitising(type, event, data),
    do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
