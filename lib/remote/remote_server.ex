defmodule Remote.RemoteServer do
  @moduledoc """
  A GenServer that maintains a random number and the last time the server was queried for information
  """

  use GenServer
  require Logger

  alias __MODULE__
  alias Remote.Users
  alias Remote.Users.User

  @type server_response :: %{
          timestamp: DateTime.t() | nil,
          users: [User.t()]
        }

  defmodule State do
    @type t :: %__MODULE__{
            max_number: 0..100,
            timestamp: nil | DateTime.t()
          }

    @moduledoc false
    defstruct [:max_number, :timestamp]
  end

  #
  # Client
  #

  @doc """
  Overriding default child_spec/1 to provide inital values and configuration
  """
  def child_spec(_opts) do
    max_number = Enum.random(0..100)
    timestamp = nil

    %{
      id: RemoteServer,
      start: {RemoteServer, :start_link, [max_number, timestamp]},
      shutdown: 15_000,
      restart: :transient
    }
  end

  @doc """
  Start the genserver with the default initial values
  """
  def start_link(max_number, timestamp) do
    case GenServer.start_link(RemoteServer, %State{max_number: max_number, timestamp: timestamp},
           name: RemoteServer
         ) do
      {:ok, pid} ->
        {:ok, pid}

      {:error, {:already_started, pid}} ->
        Logger.info(
          "A PointServer with the pid: #{inspect(pid)} already exists. Will return :ignore"
        )

        :ignore
    end
  end

  @doc """
  Request all users with points more than max_number and return 2
  """
  @spec find_users() :: {:ok, server_response()}
  def find_users() do
    response = GenServer.call(RemoteServer, :find_users)
    {:ok, response}
  end

  #
  # Server functions (callbacks)
  #

  @impl true
  def init(%State{max_number: _max_number, timestamp: nil} = initial_state) do
    # Schedule periodic server update
    schedule_update()

    {:ok, initial_state}
  end

  @impl true
  def handle_call(:find_users, _from, state) do
    users = Users.find_users(state.max_number)

    new_state = state |> update_timestamp()

    {:reply, %{users: users, timestamp: state.timestamp}, new_state}
  end

  @impl true
  def handle_info(:update_server, state) do
    Users.update_all_users()

    new_state = state |> update_timestamp()

    schedule_update()

    {:noreply, new_state}
  end

  @doc false
  defp schedule_update() do
    Process.send_after(self(), :update_server, interval())
  end

  defp update_timestamp(state) do
    %{state | timestamp: current_time()}
  end

  @doc false
  defp current_time() do
    DateTime.utc_now()
    |> DateTime.truncate(:second)
  end

  @doc false
  defp interval() do
    case Mix.env() do
      # one hundred ms for tests
      :test -> 1_000
      # one minute
      :dev -> 60_000
      # one minute
      :prod -> 60_000
    end
  end
end
