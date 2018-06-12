defmodule Gcode.Machine.Decompressing do
  @moduledoc """
  Functions for when we are in the waiting state
  """
  require Logger

  def decompressing(:internal, {:decompress, compressed_gcode}, data) do
    decompressed = LZString.decompress(compressed_gcode)

    {:next_state, :sanitising, data, [{:next_event, :internal, {:sanitise, decompressed}}]}
  end

  def decompressing({:call, from}, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled call from #{inspect from}, name: #{inspect event}, data: #{inspect data}")
    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def decompressing(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end
end
