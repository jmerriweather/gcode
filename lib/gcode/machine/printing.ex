defmodule Gcode.Machine.Printing do
  @moduledoc """
  Functions for when we are in the printing state
  """
  require Logger

  def process_gcode(pid, name, index, count, command) do
    # Output info
    IO.puts("#{inspect command}")

    # Write command to printer
    with :ok <- Nerves.UART.write(pid, command) do
      Phoenix.Tracker.update(Gcode.Tracker, self(), "printers", name, fn meta ->
        meta
          |> Map.put(:last_command, command)
          |> Map.put(:last_index, index)
          |> Map.put(:last_count, count)
      end)
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  def process_command(pid, name, command) do
    # Output info
    IO.puts("#{inspect command}")

    # Write command to printer
    with :ok <- Nerves.UART.write(pid, command) do
      Phoenix.Tracker.update(Gcode.Tracker, self(), "printers", name, fn meta -> Map.put(meta, :last_command, command) end)
      case command do
        "M77" -> {:ok, :print_finished}
        "M0" -> {:ok, :print_finished}
        _ -> {:ok, :continue}
      end
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end


  def printing(:cast, {:command, command}, data = %{extra_commands: extra_commands}) do
    {:keep_state, %{data | extra_commands: [command | extra_commands]}}
  end

  # Last command

  def printing(:internal, :print, %{gcode: nil, extra_commands: [_ | _]}) do
    {:keep_state_and_data, {:next_event, :internal, :check_command}}
  end

  def printing(:internal, :print, data = %{gcode: nil}) do
    {:next_state, :waiting, data}
  end

  def printing(:internal, :print, data = %{uart_pid: pid, name: name, gcode: gcode = %{command_index: index, command_count: count, commands: commands}}) when index < count do
    with %{raw: command} <- Map.fetch!(commands, index) do
      with :ok <- process_gcode(pid, name, index, count, command) do
        {:keep_state, %{data | gcode: %{gcode | command_index: index + 1}}}
      else
        error -> {:next_state, :error, %{data | error: error}}
      end
    else
      _ -> {:next_state, :error, %{data | error: {:unable_to_find_command_for_index, index}}}
    end
  end

  def printing(:internal, :print, data = %{gcode: %{command_index: index, command_count: count}}) when index >= count do
    {:next_state, :waiting, data}
  end

  def printing(:internal, :check_command, data = %{uart_pid: pid, name: name, extra_commands: [%{raw: command} | []]}) do
    case process_command(pid, name, command) do
      {:ok, :print_finished} ->
        {:next_state, :waiting, data}
      {:ok, :continue} ->
        {:next_state, :printing, %{data | extra_commands: []}}
      {:error, error} ->
        Logger.error("Error processing command: #{inspect error}")
        {:next_state, :error, %{data | error: error}}
    end
  end

  def printing(:internal, :check_command, data = %{uart_pid: pid, name: name, extra_commands: [%{raw: command} | rest]}) do
    case process_command(pid, name, command) do
      {:ok, :print_finished} ->
        {:next_state, :waiting, data}
      {:ok, :continue} ->
        {:next_state, :printing, %{data | extra_commands: rest}}
      {:error, error} ->
        Logger.error("Error processing command: #{inspect error}")
        {:next_state, :error, %{data | error: error}}
    end
  end

  def printing(:internal, :check_command,  _data) do
    {:keep_state_and_data, {:next_event, :internal, :print}}
  end

  def printing(:info, {:nerves_uart, _port, status}, data = %{name: name, extra_commands: [], gcode: %{command_index: index, command_count: count}}) when index >= count do
    if String.contains?(status, "ok ") do
      case String.split(status, "ok ", trim: true) do
        [command | []] -> handle_response(name, command)
        [_ | command] -> handle_response(name, command)
      end
      :keep_state_and_data
    else
      handle_status(name, status)
      :keep_state_and_data
    end
    {:next_state, :waiting, data}
  end

  def printing(:info, {:nerves_uart, _port, "ok"}, %{name: name, gcode: %{command_index: index, command_count: count}}) when index < count do
    handle_response(name, "OK")
    {:keep_state_and_data, {:next_event, :internal, :check_command}}
  end

  def printing(:info, {:nerves_uart, _port, "ok " <> command}, %{name: name, gcode: %{command_index: index, command_count: count}}) when index < count do
    handle_response(name, command)
    {:keep_state_and_data, {:next_event, :internal, :check_command}}
  end

  def printing(:info, {:nerves_uart, _port, "ok"}, %{name: name}) do
    handle_response(name, "OK")
    {:keep_state_and_data, {:next_event, :internal, :print}}
  end

  def printing(:info, {:nerves_uart, _port, "ok " <> command}, %{name: name}) do
    handle_response(name, command)
    {:keep_state_and_data, {:next_event, :internal, :print}}
  end

  def printing(:info, {:nerves_uart, _port, status}, %{name: name}) do
    if String.contains?(status, "ok ") do
      case String.split(status, "ok ", trim: true) do
        [command | []] -> handle_response(name, command)
        [_ | command] -> handle_response(name, command)
      end
      {:keep_state_and_data, {:next_event, :internal, :print}}
    else
      handle_status(name, status)
      :keep_state_and_data
    end
  end

  def printing({:call, from}, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled call from #{inspect from}, name: #{inspect event}, data: #{inspect data}")
    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def printing(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end

  def handle_status(name, status_message) do
    Phoenix.Tracker.update(Gcode.Tracker, self(), "printers", name, fn meta -> Map.put(meta, :last_status, String.trim(status_message)) end)
    IO.puts("Status: #{inspect status_message}")
  end

  def handle_response(name, response_message) do
    Phoenix.Tracker.update(Gcode.Tracker, self(), "printers", name, fn meta -> Map.put(meta, :last_response, String.trim(response_message)) end)
    IO.puts("Response: #{inspect response_message}")
  end
end
