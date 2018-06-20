defmodule Gcode.Machine do
  use GenStateMachine, callback_mode: [:handle_event_function, :state_enter]

  require Logger

  def start_link(options) do
    GenStateMachine.start_link(__MODULE__, options, name: __MODULE__)
  end

  def child_spec(options) do
    %{id: __MODULE__, type: :worker, start: {__MODULE__, :start_link, [options]}}
  end

  def init(external_options) do
    options = %{}
      |> Map.put(:port, nil)
      |> Map.put(:speed, 115200)
      |> Map.put(:autoconnect, true)
      |> Map.merge(external_options)

    name = Map.fetch!(options, :name)

    data = %{
      name: name,
      uart_pid: nil,
      uart_options: Map.take(options, [:port, :speed, :autoconnect]),
      uart_ports: %{},
      gcode: nil,
      extra_commands: [],
      error: nil
    }

    # have we been passed in a static port to connect to?
    {state, actions} = if is_nil(Map.fetch!(options, :port)) do
      # if not then enter the initialising state, attempt to locate available ports and optionally auto connect
      {:initialising, [{:next_event, :internal, :find_ports}]}
    else
      # we have been given a port, enter connecting state with static port
      {:connecting, [{:next_event, :internal, :connect}]}
    end

    Phoenix.Tracker.track(Gcode.Tracker, self(), "printers", name, %{state: state})

    {:ok, state, data, actions}
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

  def handle_event({:call, from}, {:print, _}, state, _data) when state !== :connected do
    Logger.warn("#{inspect __MODULE__} - Print command ignored, can only send the print command when the state is connected", state: state)
    {:keep_state_and_data, {:reply, from, {:error, {:printer_busy, state}}}}
  end

  def handle_event(:cast, {:command, _}, state, _data) when state !== :connected and state !== :printing do
    Logger.warn("#{inspect __MODULE__} - Command ignored, can only send commands when the state is connected or printing", state: state)
    :keep_state_and_data
  end

  def handle_event(type, event, state, data) do
    apply(__MODULE__, state, [type, event, data])
  end

  defdelegate initialising(type, event, data), to: Gcode.Machine.Initialising
  defdelegate connecting(type, event, data), to: Gcode.Machine.Connecting
  defdelegate error(type, event, data), to: Gcode.Machine.Error
  defdelegate connected(type, event, data), to: Gcode.Machine.Connected
  defdelegate decompressing(type, event, data), to: Gcode.Machine.Decompressing
  defdelegate sanitising(type, event, data), to: Gcode.Machine.Sanitising
  defdelegate parsing(type, event, data), to: Gcode.Machine.Parsing
  defdelegate analysing(type, event, data), to: Gcode.Machine.Analysing
  defdelegate printing(type, event, data), to: Gcode.Machine.Printing
end
