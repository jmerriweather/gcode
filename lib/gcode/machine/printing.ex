defmodule Gcode.Machine.Printing do
  @moduledoc """
  Functions for when we are in the printing state
  """
  require Logger

  def process_gcode(pid, command) do
    # Output info
    IO.puts("#{inspect command}")

    # Write command to printer
    Nerves.UART.write(pid, command)
  end

  def process_command(pid, command) do
    # Output info
    IO.puts("#{inspect command}")

    # Write command to printer
    with :ok <- Nerves.UART.write(pid, command) do
      case command do
        "M77" -> {:ok, :print_finished}
        _ -> {:ok, :continue}
      end
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  # Last command
  def printing(:internal, :print, data = %{uart_pid: pid, gcode_commands: [%{raw: command} | []]}) do

    process_gcode(pid, command)

    {:next_state, :waiting, %{data | gcode_commands: []}}
  end

  def printing(:internal, :print, data = %{uart_pid: pid, gcode_commands: [%{raw: command} | rest]}) do

    process_gcode(pid, command)

    {:keep_state, %{data | gcode_commands: rest}}
  end

  def printing(:timeout, :check_command, data = %{uart_pid: pid, extra_commands: [%{raw: command} | []]}) do
    case process_command(pid, command) do
      {:ok, :print_finished} ->
        {:next_state, :waiting, %{data | gcode_commands: []}}
      {:ok, :continue} ->
        {:next_state, :printing, %{data | extra_commands: []}, {:next_event, :internal, :print}}
      {:error, error} ->
        Logger.error("Error processing command: #{inspect error}")
        {:next_state, :error, %{data | error: error}}
    end
  end

  def printing(:timeout, :check_command, data = %{uart_pid: pid, extra_commands: [%{raw: command} | rest]}) do
    case process_command(pid, command) do
      {:ok, :print_finished} ->
        {:next_state, :waiting, %{data | gcode_commands: []}}
      {:ok, :continue} ->
        {:next_state, :printing, %{data | extra_commands: rest}, {:next_event, :internal, :print}}
      {:error, error} ->
        Logger.error("Error processing command: #{inspect error}")
        {:next_state, :error, %{data | error: error}}
    end
  end

  def printing(:timeout, :check_command,  _data) do
    {:keep_state_and_data, {:next_event, :internal, :print}}
  end

  def printing(:info, {:nerves_uart, _port, status}, %{extra_commands: [], gcode_commands: []}) do
    IO.puts("Status: #{inspect status}")
    :keep_state_and_data
  end

  def printing(:info, {:nerves_uart, _port, "ok"}, _data) do
    IO.puts("Response: OK")
    {:keep_state_and_data, {:timeout, 0, :check_command}}
  end

  def printing(:info, {:nerves_uart, _port, <<"ok ", command::bits>>}, _data) do
    IO.puts("Response: #{inspect command}")
    {:keep_state_and_data, {:timeout, 0, :check_command}}
  end

  def printing(:info, {:nerves_uart, _port, status}, _data) do
    IO.puts("Status: #{inspect status}")
    :keep_state_and_data
  end

  def printing({:call, from}, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled call from #{inspect from}, name: #{inspect event}, data: #{inspect data}")
    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def printing(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end
end
