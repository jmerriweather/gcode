defmodule Gcode.Handler do

  @callback init(atom, map) :: {:ok, map}

  @doc """
  Handle decompression.
  """
  @callback handle_decompression(binary, map) :: {:ok, String.t, map} | {:skip, map} | {:error, term, map}


  @doc """
  Handle what commands are sent when stop print is executed

  ```elixir
  handle_stop_print(index, count, data)
  ```
  """
  @callback handle_stop_print(number, number, map) :: {:ok, [String.t], map} | {:error, term, map}

  @doc """
  This function is called when the state of the Gcode State Machine has changed
  ```elixir
  handle_state(previous_state, new_state, data)
  ```
  """
  @callback handle_state(atom, atom, map) :: {:ok, map}

  @doc """
  When a response to a command is recieved
  """
  @callback handle_message({atom, term}, map) :: {:ok, map}

  @doc """
  Called for each gcode instruction
  ```elixir
  handle_print_time_estimate(current_coordinates = {z, y, z}, previous_coordinates = {z, y, z}, current_speed, last_known_speed, duration_accumulator) :: {:ok, duration}
  ```
  """
  @callback handle_print_time_estimate({number, number, number}, {number, number, number}, number | nil, number | nil) :: {:ok, number}


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
      def handle_stop_print(index, count, data) do
        commands = [
          "M84",
          "M104 S0",
          "M106 S0",
          "G28 X0 Y0"
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
      def handle_print_time_estimate({current_x, current_y, current_z}, {previous_x, previous_y, previous_z}, current_speed, _last_known_speed) do
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
