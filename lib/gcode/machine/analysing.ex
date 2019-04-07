defmodule Gcode.Machine.Analysing do
  @moduledoc """
  Functions for when we are in the analysing state
  """
  require Logger

  def calculate_time(0, 0, 0, 0), do: 0

  def calculate_time(x, y, _z, speed) do
    mmPerSecond =
      if speed > 0 do
        speed / 60
      else
        0
      end

    segmentLength = :math.sqrt(:math.pow(x, 2) + :math.pow(y, 2))

    duration =
      if segmentLength > 0 and mmPerSecond > 0 do
        segmentLength / mmPerSecond
      else
        0
      end

    duration
  end

  def estimate_print_time(
        handler,
        gcode = %{command_count: count, commands: commands},
        existing_x,
        existing_y,
        existing_z,
        existing_speed,
        acc_duration,
        index
      )
      when index < count do
    %GcodeCommand{instruction: _instruction, parameters: parameters} = Map.fetch!(commands, index)

    {x, y, z, speed} =
      case parameters do
        %{"X" => x, "Y" => y, "Z" => z, "F" => speed} -> {x, y, z, speed}
        %{"X" => x, "Y" => y, "Z" => z} -> {x, y, z, 0}
        %{"X" => x, "Y" => y, "F" => speed} -> {x, y, 0, speed}
        %{"X" => x, "Y" => y} -> {x, y, 0, 0}
        %{"Z" => z, "F" => speed} -> {0, 0, z, speed}
        %{"Z" => z} -> {0, 0, z, 0}
        _ -> {0, 0, 0, 0}
      end

    {:ok, new_duration} =
      apply(handler, :handle_print_time_estimate, [
        {existing_x, existing_y, existing_z},
        existing_speed,
        {x, y, z},
        speed
      ])

    estimate_print_time(handler, gcode, x, y, z, speed, acc_duration + new_duration, index + 1)
  end

  def estimate_print_time(_, %{}, _, _, _, _, duration, _), do: duration

  def analysing(
        :internal,
        :analyse,
        data = %{
          gcode: gcode = %{filename: filename},
          gcode_handler: handler,
          gcode_handler_data: gcode_handler_data
        }
      ) do
    duration = estimate_print_time(handler, gcode, 0, 0, 0, 0, 0, 0)

    with {:ok, gcode_handler_data} <- apply(handler, :handle_message, [
             {:estimated_print_time_seconds, duration},
             gcode_handler_data
           ]),
         {:ok, command_list, gcode_handler_data} <- apply(handler, :handle_print_start, [Map.put(gcode_handler_data, :filename, filename)]) do
      with {:ok, commands} <- Gcode.Machine.Parsing.extract_command_list(command_list) do
        {:next_state, :printing,
         %{
           data
           | gcode: %{gcode | estimated_print_time: duration},
             gcode_handler_data: gcode_handler_data,
             extra_commands: commands
         }, {:next_event, :internal, :print}}
      else
        _ ->
          {:next_state, :printing,
           %{
             data
             | gcode: %{gcode | estimated_print_time: duration},
               gcode_handler_data: gcode_handler_data
           }, {:next_event, :internal, :print}}
      end
    else
      {:error, error} -> {:next_state, :error, %{data | error: error}}
      error -> {:next_state, :error, %{data | error: error}}
    end
  end

  def analysing(type, event, data), do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
