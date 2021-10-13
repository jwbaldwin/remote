defmodule RemoteWeb.UserController do
  use RemoteWeb, :controller

  alias Remote.RemoteServer

  action_fallback RemoteWeb.FallbackController

  @doc """
  Endpoint that returns up to two users, and a timestamp from the RemoteServer
  """
  @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  def index(conn, _params) do
    with {:ok, %{timestamp: timestamp, users: users}} <- RemoteServer.find_users() do
      render(conn, "index.json", users: users, timestamp: timestamp)
    end
  end
end
