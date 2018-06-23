defmodule Gcode.Machine.Decompressing do
  @moduledoc """
  Functions for when we are in the decompressing state
  """
  require Logger

  # Decompression is disabled, go to next stage
  def decompressing(:internal, {:decompress, compressed_gcode}, data = %{decompression_handler: false}) do
    {:next_state, :sanitising, data, [{:next_event, :internal, {:sanitise, compressed_gcode}}]}
  end

  # Decompression has been defined
  def decompressing(:internal, {:decompress, compressed_gcode}, data = %{decompression_handler: {module, function}}) do
    decompressed = apply(module, function, compressed_gcode)

    {:next_state, :sanitising, data, [{:next_event, :internal, {:sanitise, decompressed}}]}
  end

  def decompressing(type, event, data),
    do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
