defmodule Gcode.Machine.Connecting do
  @moduledoc """
  Functions for when we are in the connecting state
  """
  require Logger

  def connecting(:internal, :connect, data = %{uart_options: %{port: nil}}) do
    {:next_state, :detecting, data, {:state_timeout, 5000, :find_ports}}
  end

  def connecting(
        :internal,
        :connect,
        data = %{
          uart_options: %{port: port, speed: speed},
          uart_ports: uart_ports,
          gcode_handler: handler,
          gcode_handler_data: gcode_handler_data
        }
      ) do
    {:ok, gcode_handler_data} =
      with %{^port => %{description: description}} <- uart_ports do
        apply(handler, :handle_message, [
          {:status,
           "About to connect to device on #{inspect(port)} with description #{
             inspect(description)
           }"},
          gcode_handler_data
        ])
      else
        _ ->
          apply(handler, :handle_message, [
            {:status, "About to connect to device on #{inspect(port)}"},
            gcode_handler_data
          ])
      end

    with {:ok, pid} <- Nerves.UART.start_link(),
         :ok <-
           Nerves.UART.open(
             pid,
             port,
             speed: speed,
             active: true,
             framing: {Nerves.UART.Framing.Line, separator: "\n"}
           ) do
      {:next_state, :connected,
       %{data | uart_pid: pid, error: nil, gcode_handler_data: gcode_handler_data}}
    else
      {:error, error} ->
        {:keep_state, %{data | error: error, gcode_handler_data: gcode_handler_data},
         {:state_timeout, 5000, :reconnect}}

      error ->
        {:keep_state, %{data | error: error, gcode_handler_data: gcode_handler_data},
         {:state_timeout, 5000, :reconnect}}
    end
  end

  def connecting(:state_timeout, :reconnect, _data) do
    {:keep_state_and_data, {:next_event, :internal, :connect}}
  end

  def connecting(type, event, data),
    do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
