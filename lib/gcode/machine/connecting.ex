defmodule Gcode.Machine.Connecting do
  @moduledoc """
  Functions for when we are in the connecting state
  """
  require Logger

  def connecting(:internal, :connect, data = %{uart_options: %{port: port, speed: speed}}) do
    with {:ok, pid} <- Nerves.UART.start_link(), :ok <- Nerves.UART.open(pid, port, speed: speed, active: true, framing: {Nerves.UART.Framing.Line, separator: "\n"}) do
      {:next_state, :connected, %{state | uart_pid: pid, error: nil}}
    else
      {:error, error} ->
        {:keep_state, %{data | error: error}, {:state_timeout, 5000, :reconnect}}
      error ->
        {:keep_state, %{data | error: error}, {:state_timeout, 5000, :reconnect}}
    end
  end

  def connecting(:state_timeout, :reconnect, data) do
    {:keep_state_and_data, {:next_event, :internal, :connect}}
  end

  def connecting(type, event, data), do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
