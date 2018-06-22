defmodule Gcode.Machine.Decompressing do
  @moduledoc """
  Functions for when we are in the decompressing state
  """
  require Logger

  def decompressing(:internal, {:decompress, compressed_gcode}, data) do
    decompressed = LZString.decompress(compressed_gcode)

    {:next_state, :sanitising, data, [{:next_event, :internal, {:sanitise, decompressed}}]}
  end

  def decompressing(type, event, data),
    do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
