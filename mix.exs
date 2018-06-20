defmodule Gcode.MixProject do
  use Mix.Project

  def project do
    [
      app: :gcode,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:retry, "~> 0.8"},
      {:nerves_uart, "~> 1.2"},
      {:gen_state_machine, "~> 2.0"},
      {:lz_string, "~> 0.0.7"},
      {:phoenix_pubsub, "~> 1.0"}
    ]
  end
end
