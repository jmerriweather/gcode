defmodule Gcode.Machine.Initialising do
  @moduledoc """
  Functions for when we are in the initialising state
  """
  require Logger

  def attempt_finding_ports(
        data = %{
          uart_options: options = %{autoconnect: autoconnect},
          gcode_handler: handler,
          gcode_handler_data: gcode_handler_data
        }
      ) do
    port_info = Nerves.UART.enumerate()

    if autoconnect do
      first_port =
        port_info
        |> Enum.filter(fn {_key, value} -> map_size(value) > 0 end)
        |> Enum.take(1)

      if first_port == [] do
        {:keep_state, %{data | uart_ports: port_info}, {:state_timeout, 5000, :find_ports}}
      else
        [{port_name, details}] = first_port

        {:ok, gcode_handler_data} =
          with %{description: description} <- details do
            apply(handler, :handle_message, [
              {:status,
               "Found device on #{inspect(port_name)} with description #{inspect(description)}"},
              gcode_handler_data
            ])
          else
            _ ->
              apply(handler, :handle_message, [
                {:status, "Found device on #{inspect(port_name)}"},
                gcode_handler_data
              ])
          end

        {:next_state, :connecting,
         %{
           data
           | uart_ports: port_info,
             uart_options: Map.put(options, :port, port_name),
             gcode_handler_data: gcode_handler_data
         }, {:next_event, :internal, :connect}}
      end
    else
      {:keep_state, %{data | uart_ports: port_info}}
    end
  end

  def initialising(:state_timeout, :find_ports, data) do
    attempt_finding_ports(data)
  end

  def initialising(:internal, :find_ports, data) do
    attempt_finding_ports(data)
  end

  def initialising(type, event, data),
    do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
