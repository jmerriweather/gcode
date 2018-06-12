defmodule Gcode.Machine.Analysing do
  @moduledoc """
  Functions for when we are in the waiting state
  """
  require Logger


  def process_parameters(["X" <> amount | rest], x, y, z, speed) do
    #IO.puts("X Rest: #{inspect amount}")
    {addition, _} = Float.parse(amount)
    process_parameters(rest, x + addition, y, z, speed)
  end

  def process_parameters(["Y" <> amount | rest], x, y, z, speed) do
    #IO.puts("Y Rest: #{inspect amount}")
    {addition, _} = Float.parse(amount)
    process_parameters(rest, x, y + addition, z, speed)
  end

  def process_parameters(["Z" <> amount | rest], x, y, z, speed) do
    #IO.puts("Z Rest: #{inspect amount}")
    {addition, _} = Float.parse(amount)
    process_parameters(rest, x, y, z + addition, speed)
  end

  def process_parameters(["F" <> amount | rest], x, y, z, speed) do
    #IO.puts("F Rest: #{inspect amount}")
    {addition, _} = Float.parse(amount)
    process_parameters(rest, x, y, z, speed + addition)
  end

  def process_parameters([unknown | rest], x, y, z, speed) do
    #IO.puts("Unknown: #{inspect unknown}")
    process_parameters(rest, x, y, z, speed)
  end

  def process_parameters([], x, y, z, speed), do: {x, y, z, speed}

  def estimate_print_time([%GcodeCommand{instruction: instruction, parameters: parameters} | rest], existing_x, existing_y, existing_z, acc_duration) do


    with {x, y, z, speed} when (x > 0 or y > 0 or z > 0) and speed != 0 <- process_parameters(parameters, 0, 0, 0, 0) do
      mmPerSecond = speed / 60
      segmentLength = :math.sqrt(:math.pow(x - existing_x, 2) + :math.pow(y - existing_y, 2) + :math.pow(z - existing_z, 2))

      duration = segmentLength / mmPerSecond
      estimate_print_time(rest, x, y, z, acc_duration + duration)
    else
      {x, y, z, speed} -> estimate_print_time(rest, x, y, z, acc_duration)
      _ -> estimate_print_time(rest, existing_x, existing_y, existing_z, acc_duration)
    end

    # movement = {new_x, new_y, new_z, speed} = process_parameters(parameters, 0, 0, 0, 0)
    # IO.puts("Movement: #{inspect movement}")
    # mmPerSecond = if speed > 0 do
    #   speed / 60
    # else
    #   0
    # end

    # deltaX = new_x - x
    # deltaY = new_y - y
    # deltaZ = new_z - z

    # segmentLength = :math.sqrt(:math.pow(deltaX, 2) + :math.pow(deltaY, 2) + :math.pow(deltaZ, 2))

    # new_duration = if segmentLength > 0 && mmPerSecond > 0 do
    #   segmentLength / mmPerSecond
    # else
    #   0
    # end

    # estimate_print_time(rest, new_x, new_y, new_z, duration + new_duration)
  end
  def estimate_print_time([], _, _, _, duration), do: duration

  def analysing(:internal, :analyse, data = %{gcode: gcode = %{commands: commands}}) do
    IO.puts("Analysing: #{inspect commands}")

    #duration = estimate_print_time(commands, 0, 0, 0, 0)
    IO.puts("Duration: #{inspect 0}")
    {:keep_state, %{data | gcode: %{gcode | estimated_print_time: 0}}}
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
