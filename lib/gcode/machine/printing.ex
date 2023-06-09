defmodule Gcode.Machine.Printing do
  @moduledoc """
  Functions for when we are in the printing state
  """
  require Logger

  @timeout 2000

  def process_gcode(pid, gcode_handler, gcode_handler_data, index, count, command) do
    # Output info
    IO.puts("#{inspect(command)}")

    # Write command to printer
    with :ok <- Nerves.UART.write(pid, command, @timeout) do
      apply(gcode_handler, :handle_message, [
        {:command, {command, index, count}},
        gcode_handler_data
      ])
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  def process_command(pid, gcode_handler, gcode_handler_data, command) do
    # Output info
    IO.puts("#{inspect(command)}")

    # Write command to printer
    with :ok <- Nerves.UART.write(pid, command, @timeout) do
      {:ok, handler_data} =
        apply(gcode_handler, :handle_message, [{:command, command}, gcode_handler_data])

      case command do
        "M77" -> {:ok, :print_finished, handler_data}
        "M0" -> {:ok, :print_finished, handler_data}
        _ -> {:ok, :continue, handler_data}
      end
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  def printing(:cast, {:command, command}, data = %{extra_commands: extra_commands}) do
    {:keep_state, %{data | extra_commands: [command | extra_commands]}}
  end

  def printing(
        :cast,
        :cancel,
        data = %{
          gcode_handler: handler,
          gcode_handler_data: handler_data,
          gcode: %{command_index: index, command_count: count}
        }
      ) do

    with {:ok, command_list, handler_data} <- apply(handler, :handle_cancel_print, [index, count, handler_data]),
         {:ok, commands} <- Gcode.Machine.Parsing.extract_command_list(command_list) do
      {:keep_state,
       %{data | gcode: nil, extra_commands: commands, gcode_handler_data: handler_data}}
    else
      {:error, error} -> {:next_state, :error, %{data | error: error}}
      error -> {:next_state, :error, %{data | error: error}}
    end
  end

  # Last command

  def printing(:internal, :print, %{extra_commands: [_ | _]}) do
    {:keep_state_and_data, {:next_event, :internal, :check_command}}
  end

  def printing(
        :internal,
        :print,
        data = %{
          uart_pid: pid,
          gcode_handler: handler,
          gcode_handler_data: handler_data,
          gcode: gcode = %{command_index: index, command_count: count, commands: commands}
        }
      )
      when index < count do
    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("PRINTING, index: #{inspect index}, count: #{inspect count}")
    with current_command <- Map.fetch!(commands, index),
         {:ok, %{raw: raw_command}, handler_data} <-
           apply(handler, :handle_print_step, [current_command, handler_data]),
         {:ok, handler_data} <-
           process_gcode(pid, handler, handler_data, index, count, raw_command) do
      Logger.warn("Next Command #{inspect(index + 1)} of #{inspect(count)}")

      {:keep_state,
       %{data | gcode: %{gcode | command_index: index + 1}, gcode_handler_data: handler_data}}
    else
      {:skip, handler_data} ->
        Logger.warn("Skipping Command #{inspect(index)} of #{inspect(count)}")

        {:keep_state,
         %{data | gcode: %{gcode | command_index: index + 1}, gcode_handler_data: handler_data}}

      error ->
        {:next_state, :error, %{data | error: error}}

      _ ->
        {:next_state, :error, %{data | error: {:unable_to_find_command_for_index, index}}}
    end
  end

  def printing(:internal, :print, data) do
    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("FOUND NOTHIGN TO PRINT, index: #{inspect index}, count: #{inspect count}")
    {:next_state, :connected, data}
  end

  def printing(
        :internal,
        :check_command,
        data = %{
          uart_pid: pid,
          gcode_handler: handler,
          gcode_handler_data: handler_data,
          extra_commands: [%{raw: command} | []]
        }
      ) do

    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("CHECK COMMAND A, index: #{inspect index}, count: #{inspect count}")

    case process_command(pid, handler, handler_data, command) do
      {:ok, :print_finished, handler_data} ->
        {:next_state, :connected, %{data | gcode_handler_data: handler_data}}

      {:ok, :continue, handler_data} ->
        {:next_state, :printing, %{data | extra_commands: [], gcode_handler_data: handler_data}}

      {:error, error} ->
        Logger.error("Error processing command: #{inspect(error)}")
        {:next_state, :error, %{data | error: error}}
    end
  end

  def printing(
        :internal,
        :check_command,
        data = %{
          uart_pid: pid,
          gcode_handler: handler,
          gcode_handler_data: handler_data,
          extra_commands: [%{raw: command} | rest]
        }
      ) do

    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("CHECK COMMAND B, index: #{inspect index}, count: #{inspect count}")
    case process_command(pid, handler, handler_data, command) do
      {:ok, :print_finished, handler_data} ->
        {:next_state, :connected, %{data | gcode_handler_data: handler_data}}

      {:ok, :continue, handler_data} ->
        {:next_state, :printing, %{data | extra_commands: rest, gcode_handler_data: handler_data}}

      {:error, error} ->
        Logger.error("Error processing command: #{inspect(error)}")
        {:next_state, :error, %{data | error: error}}
    end
  end

  def printing(:internal, :check_command, data) do
    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("CHECK COMMAND C, index: #{inspect index}, count: #{inspect count}")
    {:keep_state_and_data, {:next_event, :internal, :print}}
  end

  def printing(
        :info,
        {:nerves_uart, _port, {:error, error}},
        data = %{uart_pid: pid, uart_options: options}
      ) do
    Nerves.UART.close(pid)

    {:next_state, :error, %{data | uart_pid: nil, uart_options: Map.put(options, :port, nil)},
     {:next_event, :internal, {:uart_error, error}}}
  end

  def printing(
        :info,
        {:nerves_uart, _port, "ok" <> command},
        data = %{
          gcode_handler: handler,
          gcode_handler_data: handler_data,
          gcode: %{command_index: index, command_count: count}
        }
      )
      when index < count do

    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("MORE TO PRINT, index: #{inspect index}, count: #{inspect count}")
    {:ok, handler_data} = handle_response(handler, handler_data, String.trim(command))

    {:keep_state, %{data | gcode_handler_data: handler_data},
     {:next_event, :internal, :check_command}}
  end

  def printing(
        :info,
        {:nerves_uart, _port, "ok" <> command},
        data = %{
          gcode_handler: handler,
          gcode_handler_data: handler_data,
          gcode: %{command_index: index, command_count: count}
        }
      )
      when index == count do
    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("FINISHED PRINT, index: #{inspect index}, count: #{inspect count}")
    {:ok, handler_data} = handle_response(handler, handler_data, String.trim(command))

    with {:ok, command_list, handler_data} <- apply(handler, :handle_print_stop, [handler_data]),
         {:ok, commands} <- Gcode.Machine.Parsing.extract_command_list(command_list) do
      case commands do
        [_ | _] ->
          {:keep_state,
           %{data | gcode: nil, extra_commands: commands, gcode_handler_data: handler_data},
           {:next_event, :internal, :check_command}}

        _ ->
          {:next_state, :connected, %{data | gcode: nil, gcode_handler_data: handler_data}}
      end
    else
      {:error, error} -> {:next_state, :error, %{data | error: error}}
      error -> {:next_state, :error, %{data | error: error}}
    end
  end

  def printing(
        :info,
        {:nerves_uart, _port, "ok" <> command},
        data = %{gcode: nil, extra_commands: [], gcode_handler: handler, gcode_handler_data: handler_data}
      ) do

    Logger.debug("Message without command or gcode")
    {:ok, handler_data} = handle_response(handler, handler_data, String.trim(command))

    {:next_state, :connected, %{data | gcode_handler_data: handler_data}}
  end

  def printing(
        :info,
        {:nerves_uart, _port, "ok" <> command},
        data = %{gcode_handler: handler, gcode_handler_data: handler_data}
      ) do

    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("COMMAND, index: #{inspect index}, count: #{inspect count}")
    {:ok, handler_data} = handle_response(handler, handler_data, String.trim(command))

    {:keep_state, %{data | gcode_handler_data: handler_data},
     {:next_event, :internal, :check_command}}
  end

  def printing(
        :info,
        {:nerves_uart, _port, status},
        data = %{gcode_handler: handler, gcode_handler_data: handler_data}
      ) do
    index = with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_index), else: (_ -> nil)
    count= with %{gcode: gcode} when not is_nil(gcode) <- data, do: Map.get(gcode, :command_count), else: (_ -> nil)

    Logger.debug("STATUS MESSAGE, index: #{inspect index}, count: #{inspect count}")

    # if String.contains?(status, "ok ") do
    #   {:ok, handler_data} =
    #     case String.split(status, "ok ", trim: true) do
    #       [command | []] -> handle_response(handler, handler_data, command)
    #       [_ | command] -> handle_response(handler, handler_data, command)
    #       [] -> handle_response(handler, handler_data, "OK")
    #     end

    #   {:keep_state, %{data | gcode_handler_data: handler_data},
    #    {:next_event, :internal, :check_command}}
    # else
      {:ok, handler_data} = handle_status(handler, handler_data, status)
      {:keep_state, %{data | gcode_handler_data: handler_data}}
    # end
  end

  def printing(type, event, data), do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)

  def handle_status(handler, handler_data, status_message) do
    trimmed = String.trim(status_message)
    IO.puts("Status: #{inspect(trimmed)}")
    apply(handler, :handle_message, [{:status, trimmed}, handler_data])
  end

  def handle_response(handler, handler_data, "") do
    IO.puts("Response: OK")
    apply(handler, :handle_message, [{:response, "OK"}, handler_data])
  end

  def handle_response(handler, handler_data, response_message) do
    trimmed = String.trim(response_message)
    IO.puts("Response: #{inspect(trimmed)}")
    apply(handler, :handle_message, [{:response, trimmed}, handler_data])
  end
end
