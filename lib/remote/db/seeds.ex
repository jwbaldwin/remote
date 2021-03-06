defmodule Mix.Tasks.Remote.Db.Seeds do
  @moduledoc """
  A mix task for seeding the database with 1_000_000 users.
  Can be extended to provide different seeds for each environment.

  This module is called during `mix ecto.setup`
  """
  use Mix.Task
  alias Remote.Repo
  alias Remote.Users.User
  alias Remote.Time

  # PostgreSQL limits the maximum parameters allowed to 65535
  # And we have 3 parameters for each user (:points, :inserted_at, :updated_at)
  @batch_size div(65_535, 3)

  @total_users 1_000_000

  @impl Mix.Task
  def run(_) do
    Mix.Task.run("app.start", [])
    seed(Mix.env())
  end

  @doc """
  Defines a seed/1 function for populating the database with users
  """
  @spec seed(:dev | :prod | :test) :: :ok
  def seed(_environment) do
    now = Time.utc_now()

    users =
      1..@total_users
      |> Enum.map(fn _user -> %{points: 0, inserted_at: now, updated_at: now} end)

    # This chunks our users into manageable batches before we insert
    Enum.chunk_every(users, @batch_size)
    |> Task.async_stream(fn chunk_of_users ->
      Repo.insert_all(User, chunk_of_users)
    end)
    |> Enum.to_list()

    :ok
  end
end
