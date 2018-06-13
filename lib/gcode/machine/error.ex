defmodule Gcode.Machine.Error do
  @moduledoc """
  Functions for when we are in the waiting state
  """
  require Logger

  def error(type, event, data) do
    Logger.warn("#{inspect __MODULE__} - Unhandled event while in Error state, type: #{inspect type}, name: #{inspect event}, data: #{inspect data}")
    :keep_state_and_data
  end
end
