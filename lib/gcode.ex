defmodule Gcode do
  @moduledoc """
  Documentation for Gcode.
  """
  defstruct [
    filename: nil,
    commands: %{},
    command_index: 0,
    command_count: 0,
    estimated_print_time: nil
  ]
end
