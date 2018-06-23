defmodule Gcode.Machine.State do
  @type t :: %Gcode.Machine.State{name: String.t(), pubsub_name: atom, tracker_name: atom, decompression_handler: boolean | {module, atom}, uart_pid: nil | identifier, uart_options: map, uart_ports: map, gcode: nil | Gcode, extra_commands: list, error: nil | {:error, term}}

  defstruct name: nil,
            pubsub_name: nil,
            tracker_name: nil,
            decompression_handler: false,
            uart_pid: nil,
            uart_options: %{},
            uart_ports: %{},
            gcode: nil,
            extra_commands: [],
            error: nil
end
