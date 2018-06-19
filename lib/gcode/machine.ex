defmodule Gcode.Machine do
  use GenStateMachine, callback_mode: [:handle_event_function, :state_enter]

  def start_link(options) do
    GenStateMachine.start_link(__MODULE__, options, name: __MODULE__)
  end

  def init(options) do
    name = Keyword.fetch!(options, :name)
    port = Keyword.fetch!(options, :port)
    speed = Keyword.get(options, :speed, 115200)

    state = %{
      name: name,
      uart_pid: nil,
      gcode: nil,
      extra_commands: [],
      error: nil
    }

    with {:ok, pid} <- Nerves.UART.start_link(), :ok <- Nerves.UART.open(pid, port, speed: speed, active: true, framing: {Nerves.UART.Framing.Line, separator: "\n"}) do
      Phoenix.Tracker.track(Gcode.Tracker, self(), "printers", name, %{state: :waiting})
      {:ok, :waiting, %{state | uart_pid: pid}}
    else
      _ -> {:stop, :invalid_uart}
    end
  end

  def send_command(command) do
    with {1, %{0 => parsed_command}} <- Gcode.Machine.Parsing.extract_commands([command], %{}, 0) do
      GenStateMachine.cast(__MODULE__, {:command, parsed_command})
    end
  end

  def print(compressed_gcode) do
    GenStateMachine.call(__MODULE__, {:print, compressed_gcode})
  end

  def handle_event(:enter, old_state, new_state, %{name: name}) when old_state !== new_state do
    Phoenix.Tracker.update(Gcode.Tracker, self(), "printers", name, fn meta -> Map.put(meta, :state, new_state) end)
    :keep_state_and_data
  end

  def handle_event(:enter, _, _, _), do: :keep_state_and_data

  def handle_event(type, event, state, data) do
    apply(Gcode.Machine, state, [type, event, data])
  end

  defdelegate error(type, event, data), to: Gcode.Machine.Error
  defdelegate waiting(type, event, data), to: Gcode.Machine.Waiting
  defdelegate decompressing(type, event, data), to: Gcode.Machine.Decompressing
  defdelegate parsing(type, event, data), to: Gcode.Machine.Parsing
  defdelegate sanitising(type, event, data), to: Gcode.Machine.Sanitising
  defdelegate analysing(type, event, data), to: Gcode.Machine.Analysing
  defdelegate printing(type, event, data), to: Gcode.Machine.Printing
end
