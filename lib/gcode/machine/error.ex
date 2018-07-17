defmodule Gcode.Machine.Error do
  @moduledoc """
  Functions for when we are in the error state
  """
  require Logger

  def error(
        :internal,
        {:uart_error, error},
        data = %{
          uart_options: %{autoconnect: autoconnect},
          gcode_handler: handler,
          gcode_handler_data: gcode_handler_data
        }
      ) do
    Logger.error("UART Error occured: #{error}")

    {:ok, gcode_handler_data} =
      if autoconnect do
        apply(handler, :handle_message, [
          {:status, "Port disconnected, will attempt to connect to a new port in 5 seconds"},
          gcode_handler_data
        ])
      else
        apply(handler, :handle_message, [
          {:status, "Port disconnected, autoconnect is disabled"},
          gcode_handler_data
        ])
      end

    {:next_state, :detecting, %{data | gcode: nil, extra_commands: [], gcode_handler_data: gcode_handler_data},
     {:state_timeout, 5000, :find_ports}}
  end

  def error(type, event, data) do
    Logger.warn(
      "#{inspect(__MODULE__)} - Unhandled event while in Error state, type: #{inspect(type)}, name: #{
        inspect(event)
      }, data: #{inspect(data)}"
    )

    :keep_state_and_data
  end

  def unknown(module, {:call, from}, event, data) do
    Logger.warn(
      "#{inspect(module)} - Unhandled call from #{inspect(from)}, name: #{inspect(event)}, data: #{
        inspect(data)
      }"
    )

    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def unknown(module, type, event, data) do
    Logger.warn(
      "#{inspect(module)} - Unhandled event, type: #{inspect(type)}, name: #{inspect(event)}, data: #{
        inspect(data)
      }"
    )

    :keep_state_and_data
  end
end
