defmodule GcodeCommand do
  @type t :: %GcodeCommand{instruction: String.t | nil, parameters: %{required(String.t) => term}, raw: String.t}

  defstruct instruction: nil,
            parameters: %{},
            raw: ""
end
