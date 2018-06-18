defmodule Gcode.Machine.Waiting do
  @moduledoc """
  Functions for when we are in the waiting state
  """
  require Logger

  def waiting(:info, {:nerves_uart, port, status}, data), do: Gcode.Machine.Printing.printing(:info, {:nerves_uart, port, status}, data)

  def waiting({:call, from}, {:print, compressed_gcode}, data) do
    {:next_state, :decompressing, data, [{:reply, from, :ok}, {:next_event, :internal, {:decompress, compressed_gcode}}]}
  end

  def waiting(:cast, {:command, command}, data = %{extra_commands: extra_commands}) do
    {:next_state, :printing, %{data | extra_commands: [command | extra_commands]}, {:next_event, :internal, :check_command}}
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
