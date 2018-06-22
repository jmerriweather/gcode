defmodule Gcode.Machine.Initialising do
  @moduledoc """
  Functions for when we are in the initialising state
  """
  require Logger

  def attempt_finding_ports(
        data = %{
          name: name,
          tracker_name: tracker_name,
          uart_options: options = %{autoconnect: autoconnect}
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

        with %{description: description} <- details do
          Phoenix.Tracker.update(tracker_name, self(), "printers", name, fn meta ->
            Map.put(
              meta,
              :last_status,
              "Found device on #{inspect(port_name)} with description #{inspect(description)}"
            )
          end)
        else
          _ ->
            Phoenix.Tracker.update(tracker_name, self(), "printers", name, fn meta ->
              Map.put(meta, :last_status, "Found device on #{inspect(port_name)}")
            end)
        end

        {:next_state, :connecting,
         %{data | uart_ports: port_info, uart_options: Map.put(options, :port, port_name)},
         {:next_event, :internal, :connect}}
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
