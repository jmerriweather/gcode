defmodule Gcode.Machine.Error do
  @moduledoc """
  Functions for when we are in the error state
  """
  require Logger

  def error(:internal, {:uart_error, error}, data) do
    Logger.error("UART Error occured: #{error}")
    {:next_state, :initialising, data, {:state_timeout, 5000, :find_ports}}
  end

  def error(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event while in Error state, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end

  def unknown(module, {:call, from}, event, data) do
    Logger.warn("#{inspect module} - Unhandled call from #{inspect from}, name: #{inspect event}, data: #{inspect data}")
    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def unknown(module, type, event, data) do
    Logger.warn("#{inspect module} - Unhandled event, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end
end
