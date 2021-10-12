defmodule Remote.Db.Schema do
  @moduledoc """
  This modules is a custom schema to be used in the application that
  configures the @timestamps_opts to have type :utc_datetime
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @timestamps_opts [type: :utc_datetime]
    end
  end
end
