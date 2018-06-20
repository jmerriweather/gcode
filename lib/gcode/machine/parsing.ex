defmodule Gcode.Machine.Parsing do
  @moduledoc """
  Functions for when we are in the parsing state
  """
  require Logger


  def parse_float(num) do
    {result, _} = Float.parse(num)
    result
  end

  defp extract_parameters([<<letter::utf8, "">> | rest], acc) do
    extract_parameters(rest, Map.put(acc, <<letter>>, ""))
  end
  defp extract_parameters([<<letter::utf8, value::binary>> | rest], acc) do
    extract_parameters(rest, Map.put(acc, <<letter>>, parse_float(value)))
  end
  defp extract_parameters([], acc), do: acc

  def extract_commands([head | rest], acc, count) do
    [instruction | parameters] = String.split(head)
    extract_commands(rest, Map.put(acc, count, %GcodeCommand{instruction: instruction, parameters: extract_parameters(parameters, %{}), raw: head}), count + 1)
  end
  def extract_commands([], acc, count), do: {count, acc}

  def parsing(:internal, {:parse, sanitised_gcode}, data) do

    {count, commands} = extract_commands(sanitised_gcode, %{}, 0)

    {:next_state, :analysing, %{data | gcode: %Gcode{commands: commands, command_count: count}}, [{:next_event, :internal, :analyse}]}
  end

  def parsing(type, event, data), do: Gcode.Machine.Error.unknown(__MODULE__, type, event, data)
end
