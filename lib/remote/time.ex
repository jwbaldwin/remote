defmodule Remote.Time do
  @moduledoc """
  A collection of common time functions
  """

  @doc """
  Returns DateTime.utc_now() truncated to second
  """
  def utc_now() do
    DateTime.utc_now()
    |> DateTime.truncate(:second)
  end
end
