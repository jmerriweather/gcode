defmodule Gcode.Machine.State do
  @type t :: %Gcode.Machine.State{
          name: String.t(),
          pubsub_name: atom,
          tracker_name: atom,
          gcode_handler: module,
          gcode_handler_data: map,
          uart_pid: nil | identifier,
          uart_options: map,
          uart_ports: map,
          gcode: nil | Gcode,
          extra_commands: list,
          error: nil | {:error, term}
        }

  defstruct name: nil,
            pubsub_name: nil,
            tracker_name: nil,
            gcode_handler: Gcode.DefaultHandler,
            gcode_handler_data: %{name: nil},
            uart_pid: nil,
            uart_options: %{},
            uart_ports: %{},
            gcode: nil,
            extra_commands: [],
            error: nil
end
