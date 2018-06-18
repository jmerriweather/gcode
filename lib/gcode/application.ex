defmodule Gcode.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Phoenix.PubSub.PG2, [Gcode.PubSub, []]),
      worker(Gcode.Tracker, [[name: Gcode.Tracker, pubsub_server: Gcode.PubSub]])
    ]

    opts = [strategy: :one_for_one, name: Gcode.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
