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
    options =
      %{}
      |> Map.put(:port, nil)
      |> Map.put(:speed, 115_200)
      |> Map.put(:autoconnect, true)
      |> Map.put(:gcode_handler, Gcode.DefaultHandler)
      |> Map.merge(external_options)

    name = Map.fetch!(options, :name)
    gcode_handler = Map.fetch!(options, :gcode_handler)
    gcode_handler_data = %{name: name}

    data = %Gcode.Machine.State{
      name: name,
      gcode_handler: gcode_handler,
      gcode_handler_data: gcode_handler_data,
      uart_pid: nil,
      uart_options: Map.take(options, [:port, :speed, :autoconnect]),
      uart_ports: %{},
      gcode: nil,
      extra_commands: [],
      error: nil
    }

    # have we been passed in a static port to connect to?
    {state, actions} =
      if is_nil(Map.fetch!(options, :port)) do
        # if not then enter the detecting state, attempt to locate available ports and optionally auto connect
        {:detecting, [{:next_event, :internal, :find_ports}]}
      else
        # we have been given a port, enter connecting state with static port
        {:connecting, [{:next_event, :internal, :connect}]}
      end

    {:ok, gcode_handler_data} = apply(gcode_handler, :init, [state, gcode_handler_data])

    {:ok, state, %{data | gcode_handler_data: gcode_handler_data}, actions}
  end

  def send_command(command) do
    with {1, %{0 => parsed_command}} <- Gcode.Machine.Parsing.extract_commands([command], %{}, 0) do
      GenStateMachine.cast(__MODULE__, {:command, parsed_command})
    end
  end

  def print(filename, compressed_gcode) do
    GenStateMachine.call(__MODULE__, {:print, filename, compressed_gcode})
  end

  def cancel() do
    GenStateMachine.cast(__MODULE__, :cancel)
  end

  def handle_event(
        :enter,
        old_state,
        new_state,
        data = %{gcode_handler: handler, gcode_handler_data: handler_data}
      )
      when old_state !== new_state do
    {:ok, handler_data} = apply(handler, :handle_state, [old_state, new_state, handler_data])
    {:keep_state, %{data | gcode_handler_data: handler_data}}
  end

  def handle_event(:enter, _, _, _), do: :keep_state_and_data

  def handle_event({:call, from}, :cancel, state, _data) when state != :printing do
    Logger.warn(
      "#{inspect(__MODULE__)} - Cancel command ignored, can only send the cancel command when the state is printing",
      printer_state: state
    )

    {:keep_state_and_data, {:reply, from, {:error, {:printer_busy, state}}}}
  end

  def handle_event({:call, from}, {:print, _, _}, state, _data) when state != :connected do
    Logger.warn(
      "#{inspect(__MODULE__)} - Print command ignored, can only send the print command when the state is connected",
      printer_state: state
    )

    {:keep_state_and_data, {:reply, from, {:error, {:printer_busy, state}}}}
  end

  def handle_event(:cast, {:command, _}, state, _data)
      when state != :connected and state != :printing do
    Logger.warn(
      "#{inspect(__MODULE__)} - Command ignored, can only send commands when the state is connected or printing. State: #{
        inspect(state)
      }",
      printer_state: state
    )

    :keep_state_and_data
  end

  def handle_event(type, event, state, data) do
    Logger.info(fn -> "State: #{inspect(type)}, #{inspect(event)}, #{inspect(state)}" end)

    apply(__MODULE__, state, [type, event, data])
  end

  defdelegate detecting(type, event, data), to: Gcode.Machine.Detecting
  defdelegate connecting(type, event, data), to: Gcode.Machine.Connecting
  defdelegate error(type, event, data), to: Gcode.Machine.Error
  defdelegate connected(type, event, data), to: Gcode.Machine.Connected
  defdelegate decompressing(type, event, data), to: Gcode.Machine.Decompressing
  defdelegate sanitising(type, event, data), to: Gcode.Machine.Sanitising
  defdelegate parsing(type, event, data), to: Gcode.Machine.Parsing
  defdelegate analysing(type, event, data), to: Gcode.Machine.Analysing
  defdelegate printing(type, event, data), to: Gcode.Machine.Printing
end
