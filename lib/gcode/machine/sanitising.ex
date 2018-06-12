defmodule Gcode.Machine.Sanitising do
  @moduledoc """
  Functions for when we are in the waiting state
  """
  require Logger

  def sanitising(:internal, {:sanitise, decompressed}, data) do
    sanitised_gcode = String.split(decompressed, ~r/\R/)
      # remove lines starting with a comment
      |> Stream.reject(&String.starts_with?(&1, [";"]))
      # remove comments from the end of lines
      |> Stream.map(&(String.split(&1, ";") |> hd()))
      # remove any excess whitespace
      |> Stream.map(&String.trim(&1))
      # removed empty strings
      |> Stream.reject(&(&1 == ""))
      # make stream into a list
      |> Enum.to_list()

    {:next_state, :parsing, data, [{:next_event, :internal, {:parse, sanitised_gcode}}]}
  end

  def sanitising({:call, from}, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled call from #{inspect from}, name: #{inspect event}, data: #{inspect data}")
    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def sanitising(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end
end
