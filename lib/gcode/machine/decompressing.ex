defmodule Gcode.Machine.Decompressing do
  @moduledoc """
  Functions for when we are in the decompressing state
  """
  require Logger

  def decompressing(
        :internal,
        {:decompress, filename, compressed_gcode},
        data = %{gcode_handler: handler, gcode_handler_data: gcode_handler_data}
      ) do
    case apply(handler, :handle_decompression, [compressed_gcode, gcode_handler_data]) do
      # handler requests a skip
      {:skip, handler_data} ->
        {:next_state, :sanitising, %{data | gcode_handler_data: handler_data},
         [{:next_event, :internal, {:sanitise, filename, compressed_gcode}}]}

      # handler decompresses the data
      {:ok, decompressed, handler_data} ->
        {:next_state, :sanitising, %{data | gcode_handler_data: handler_data},
         [{:next_event, :internal, {:sanitise, filename, decompressed}}]}

      # handler has an error
      {:error, message, handler_data} ->
        {:next_state, :error, %{data | error: message, gcode_handler_data: handler_data}}
    end
  end

  def decompressing(type, event, data),
    do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
