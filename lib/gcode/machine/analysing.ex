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

  def calculate_time(0, 0, 0, 0), do: 0
  def calculate_time(x, y, z, speed) do
    mmPerSecond = if speed > 0 do
      speed / 60
    else
      0
    end

    segmentLength = :math.sqrt(:math.pow(x, 2) + :math.pow(y, 2) + :math.pow(z, 2))

    duration = if segmentLength > 0 and mmPerSecond > 0 do
      segmentLength / mmPerSecond
    else
      0
    end

    duration
  end

  def parse_float(num) do
    {result, _} = Float.parse(num)
    result
  end

  def rate_of_acc(0, _), do: 0.5
  def rate_of_acc(_, 0), do: 0.5
  def rate_of_acc(existing_speed, speed) do
    if existing_speed > speed, do: speed / existing_speed, else: existing_speed / speed
  end

  def estimate_print_time([%GcodeCommand{instruction: instruction, parameters: parameters} | rest], existing_x, existing_y, existing_z, existing_speed, acc_duration) do
    {x, y, z, speed} = coords = case parameters do
        %{"X" => x, "Y" => y, "Z" => z, "F" => speed} -> {parse_float(x), parse_float(y), parse_float(z), parse_float(speed)}
        %{"X" => x, "Y" => y, "Z" => z} -> {parse_float(x), parse_float(y), parse_float(z), existing_speed}
        %{"X" => x, "Y" => y, "F" => speed} -> {parse_float(x), parse_float(y), 0, parse_float(speed)}
        %{"X" => x, "Y" => y} -> {parse_float(x), parse_float(y), 0, existing_speed}
        %{"Z" => z, "F" => speed} -> {0, 0, parse_float(z), speed}
        %{"Z" => z} -> {0, 0, parse_float(z), existing_speed}
        _ -> {0, 0, 0, existing_speed}
      end

    deltaX = if x < existing_x, do: 0, else: x - existing_x
    deltaY = if y < existing_y, do: 0, else: y - existing_y
    deltaZ = if z < existing_z, do: 0, else: z - existing_z

    new_duration = calculate_time(deltaX, deltaY, deltaZ, rate_of_acc(existing_speed, speed) * (existing_speed - speed))

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
