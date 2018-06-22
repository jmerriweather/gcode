defmodule Gcode.Machine.Error do
  @moduledoc """
  Functions for when we are in the error state
  """
  require Logger

  def error(
        :internal,
        {:uart_error, error},
        data = %{
          name: name,
          tracker_name: tracker_name,
          uart_options: %{autoconnect: autoconnect}
        }
      ) do
    Logger.error("UART Error occured: #{error}")

    if autoconnect do
      Phoenix.Tracker.update(tracker_name, self(), "printers", name, fn meta ->
        Map.put(
          meta,
          :last_status,
          "Port disconnected, will attempt to connect to a new port in 5 seconds"
        )
      end)
    else
      Phoenix.Tracker.update(tracker_name, self(), "printers", name, fn meta ->
        Map.put(meta, :last_status, "Port disconnected, autoconnect is disabled")
      end)
    end

    {:next_state, :initialising, data, {:state_timeout, 5000, :find_ports}}
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
