defmodule Gcode.Machine.Initialising do
  @moduledoc """
  Functions for when we are in the initialising state
  """
  require Logger

  def initialising(:internal, :find_port, data = %{uart_options: options = %{autoconnect: autoconnect}}) do
    port_info = Nerves.UART.enumerate()

    if autoconnect do
      ports = Map.keys(port_info)
      first_port = List.first(ports)

      {:next_state, :connecting, %{data | uart_ports: port_info, uart_options: Map.put(options, :port, first_port)}, {:next_event, :internal, :connect}}
    else
      {:keep_state, %{data | uart_ports: port_info}}
    end
  end

  def initialising(type, event, data), do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
