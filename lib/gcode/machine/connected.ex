defmodule Gcode.Machine.Connected do
  @moduledoc """
  Functions for when we are in the connected state
  """
  require Logger

  def connected(:info, {:nerves_uart, port, status}, data),
    do: Gcode.Machine.Printing.printing(:info, {:nerves_uart, port, status}, data)

  def connected({:call, from}, {:print, filename, compressed_gcode}, data) do
    {:next_state, :decompressing, data,
     [{:reply, from, :ok}, {:next_event, :internal, {:decompress, filename, compressed_gcode}}]}
  end

  def connected(:cast, {:command, command}, data = %{extra_commands: extra_commands}) do
    {:next_state, :printing, %{data | extra_commands: [command | extra_commands]},
     {:next_event, :internal, :check_command}}
  end

  def connected(type, event, data), do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
