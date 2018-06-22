defmodule Gcode.Supervisor do
  use Supervisor

  def start_link([_config, opts] = args) do
    Supervisor.start_link(__MODULE__, args, opts)
  end

  def start_link([config]) do
    start_link([config, []])
  end

  @doc false
  @impl Supervisor
  def init([config, opts]) do
    opts = Keyword.put(opts, :strategy, :one_for_one)

    pubsub_name = Map.get(config, :pubsub_name, Gcode.PubSub)
    tracker_name = Map.get(config, :tracker_name, Gcode.Tracker)

    children = [
      {Phoenix.PubSub.PG2, [name: pubsub_name]},
      {Gcode.Tracker, [name: tracker_name, pubsub_server: pubsub_name]},
      {Gcode.Machine, config}
    ]

    Supervisor.init(children, opts)
  end
end
