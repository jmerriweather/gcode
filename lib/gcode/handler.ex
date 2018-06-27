defmodule Gcode.Handler do

  @callback init(atom, map) :: {:ok, map}

  @doc """
  Handle decompression.
  """
  @callback handle_decompression(binary, map) :: {:ok, String.t, map} | {:skip, map} | {:error, term, map}

  @doc """
  Allows you to send commands before the print has begun printing.

  ```elixir
  def handle_print_start(data) do
    my_start_commands = ["GCODE", "COMMANDS"]
    {:ok, my_start_commands, data}
  end
  ```
  """
  @callback handle_print_start(map) :: {:ok, [String.t], map} | {:error, term, map}

  @doc """
  Allows you to send commands after the print has finished.

  ```elixir
  def handle_print_stop(data) do
    my_stop_commands = ["GCODE", "COMMANDS"]
    {:ok, my_stop_commands, data}
  end
  ```
  """
  @callback handle_print_stop(map) :: {:ok, [String.t], map} | {:error, term, map}


  @doc """
  Allows you to compare the last command with the current command and change the command before it is executed

  ```elixir
  def handle_print_step(_, current_command = %{parameters: %{"Z" => current_z}}, data = %{last_z: last_z}) when current_z > last_z do

    # take picture when the Z hight changes
    Logger.info("TAKE PICTURE")

    {:ok, current_command, data}
  end

  def handle_print_step(_previous_command, current_command, data) do
    {:ok, current_command, data}
  end
  ```
  """
  @callback handle_print_step(GcodeCommand.t | nil, GcodeCommand.t, map) :: {:ok, GcodeCommand.t, map} | {:skip, map} | {:error, term, map}


  @doc """
  Handle what commands are sent when cancel print is executed

  ```elixir
  def handle_cancel_print(index, count, data) do
    my_cancel_commands = ["GCODE", "COMMANDS"]
    {:ok, my_cancel_commands, data}
  end
  ```
  """
  @callback handle_cancel_print(number, number, map) :: {:ok, [String.t], map} | {:error, term, map}

  @doc """
  This function is called when the state of the Gcode State Machine has changed

  ```elixir
  def handle_state(previous_state, new_state, data) do
    {:ok, map}
  end
  ```
  """
  @callback handle_state(atom, atom, map) :: {:ok, map}

  @doc """
  When a response to a command is recieved
  """
  @callback handle_message({atom, term}, map) :: {:ok, map}

  @doc """
  Called for each gcode instruction in the analysing stage before printing has begun.

  ```elixir
  def handle_print_time_estimate(previous_coordinates = {z, y, z}, last_known_speed, current_coordinates = {z, y, z}, current_speed) do
    new_duration = calculate_duration(x, y, z)
    {:ok, new_duration}
  end
  ```
  """
  @callback handle_print_time_estimate({number, number, number}, number | nil, {number, number, number}, number | nil) :: {:ok, number} | {:error, term}


      @doc false
  defmacro __using__(_) do
    quote location: :keep do
      @behaviour Gcode.Handler

      @doc false
      def init(state, data) do
        {:ok, data}
      end

      @doc false
      def handle_decompression(_compressed_data, data) do
        {:skip, data}
      end

      @doc false
      def handle_print_start(data) do
        {:ok, [], data}
      end

      @doc false
      def handle_print_step(previous_command, current_command, data) do
        {:ok, current_command, data}
      end

      @doc false
      def handle_print_stop(data) do
        {:ok, [], data}
      end

      @doc false
      def handle_cancel_print(index, count, data) do
        commands = [
          # retract
          "G1 E-1 F300",
          # turn off hot end
          "M104 S0",
          # turn off heated bed
          "M140 S0",
          # turn off fan
          "M106 S0",
          # Home X and Y axis
          "G28 X0 Y0",
          # Disable stepper motors
          "M18"
        ]
        {:ok, commands, data}
      end

      @doc false
      def handle_state(_previous_state, new_state, data) do
        {:ok, data}
      end

      @doc false
      def handle_message(message, data) do
        {:ok, data}
      end

      @doc false
      def handle_print_time_estimate({previous_x, previous_y, previous_z}, _last_known_speed, {current_x, current_y, current_z}, current_speed) do
        deltaX = if current_x < previous_x, do: 0, else: current_x - previous_x
        deltaY = if current_y < previous_y, do: 0, else: current_y - previous_y
        deltaZ = if current_z < previous_z, do: 0, else: current_z - previous_z

        {:ok, calculate_time(deltaX, deltaY, deltaZ, current_speed)}
      end

      defp calculate_time(0, 0, 0, 0), do: 0
      defp calculate_time(x, y, _z, speed) do
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

      defoverridable Gcode.Handler
    end
  end
end
