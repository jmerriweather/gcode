defmodule Gcode do
  @type t :: %Gcode{filename: String.t | nil, commands: %{required(integer) => GcodeCommand.t}, command_index: integer, command_count: integer, estimated_print_time: number}


  @moduledoc """
  Documentation for Gcode.
  """
  defstruct filename: nil,
            commands: %{},
            command_index: 0,
            command_count: 0,
            estimated_print_time: nil
end
