defmodule RemoteWeb.UserController do
  use RemoteWeb, :controller

  alias Remote.Users

  action_fallback RemoteWeb.FallbackController

  def index(conn, _params) do
    users = Users.find_users(1)
    render(conn, "index.json", users: users)
  end
end
