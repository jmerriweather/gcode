defmodule Gcode.Machine.Analysing do
  @moduledoc """
  Functions for when we are in the waiting state
  """
  require Logger

  def calculate_time(0, 0, 0, 0), do: 0
  def calculate_time(x, y, z, speed) do
    mmPerSecond = if speed > 0 do
      speed / 60
    else
      0
    end

    segmentLength = :math.sqrt(:math.pow(x, 2) + :math.pow(y, 2))

    duration = if segmentLength > 0 and mmPerSecond > 0 do
      segmentLength / mmPerSecond
    else
      0
    end

    duration
  end

  def estimate_print_time([%GcodeCommand{instruction: instruction, parameters: parameters} | rest], existing_x, existing_y, existing_z, existing_speed, acc_duration) do
    {x, y, z, speed} = coords = case parameters do
        %{"X" => x, "Y" => y, "Z" => z, "F" => speed} -> {x, y, z, speed}
        %{"X" => x, "Y" => y, "Z" => z} -> {x, y, z, 0}
        %{"X" => x, "Y" => y, "F" => speed} -> {x, y, 0, speed}
        %{"X" => x, "Y" => y} -> {x, y, 0, 0}
        %{"Z" => z, "F" => speed} -> {0, 0, z, speed}
        %{"Z" => z} -> {0, 0, z, 0}
        _ -> {0, 0, 0, 0}
      end

    deltaX = if x < existing_x, do: 0, else: x - existing_x
    deltaY = if y < existing_y, do: 0, else: y - existing_y
    deltaZ = if z < existing_z, do: 0, else: z - existing_z

    new_duration = calculate_time(deltaX, deltaY, deltaZ, speed)

    #IO.puts(" #{inspect acc_duration}, new duration: #{inspect new_duration}, I: #{inspect instruction}, Coords: #{inspect coords}, params: #{inspect parameters}")

    estimate_print_time(rest, x, y, z, speed, acc_duration + new_duration)
  end
  def estimate_print_time([], _, _, _, _, duration), do: duration

  def analysing(:internal, :analyse, data = %{gcode: gcode = %{commands: commands}}) do
    IO.puts("Analysing: #{inspect commands}")

    duration = estimate_print_time(commands, 0, 0, 0, 0, 0)
    IO.puts("Duration: #{inspect duration}")
    IO.puts("Duration Minutes: #{inspect duration / 60}")
    IO.puts("Duration hours: #{inspect duration / 60 / 60}")
    #:keep_state_and_data
    {:next_state, :printing, %{data | gcode: %{gcode | estimated_print_time: duration}}, {:next_event, :internal, :print}}
  end

  def analysing({:call, from}, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled call from #{inspect from}, name: #{inspect event}, data: #{inspect data}")
    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def analysing(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end
end
