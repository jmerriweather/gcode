defmodule Gcode.Machine.Parsing do
  @moduledoc """
  Functions for when we are in the waiting state
  """
  require Logger


  def parse_float(num) do
    {result, _} = Float.parse(num)
    result
  end

  defp extract_parameters([<<letter::utf8, value::binary>> | rest], acc) do
    extract_parameters(rest, Map.put(acc, <<letter>>, parse_float(value)))
  end
  defp extract_parameters([], acc), do: acc

  def extract_commands([head | rest], acc, count) do
    [instruction | parameters] = String.split(head)
    extract_commands(rest, [%GcodeCommand{instruction: instruction, parameters: extract_parameters(parameters, %{}), raw: head} | acc], count + 1)
  end
  def extract_commands([], acc, count), do: {count, Enum.reverse(acc)}

  def parsing(:internal, {:parse, sanitised_gcode}, data) do

    {count, commands} = extract_commands(sanitised_gcode, [], 0)

    {:next_state, :analysing, %{data | gcode: %Gcode{commands: commands, command_count: count}, gcode_commands: commands}, [{:next_event, :internal, :analyse}]}
  end

  def parsing({:call, from}, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled call from #{inspect from}, name: #{inspect event}, data: #{inspect data}")
    {:keep_state_and_data, {:reply, from, {:error, :unknown_call}}}
  end

  def parsing(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end
end
