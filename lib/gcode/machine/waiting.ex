defmodule Gcode.Machine.Waiting do
  @moduledoc """
  Functions for when we are in the waiting state
  """
  require Logger

  def waiting({:call, from}, {:print, compressed_gcode}, data) do
    {:next_state, :decompressing, data, [{:reply, from, :ok}, {:next_event, :internal, {:decompress, compressed_gcode}}]}
  end

  def waiting({:call, from}, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled call from #{inspect from}, name: #{inspect event}, data: #{inspect data}")
    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def waiting(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end
end
