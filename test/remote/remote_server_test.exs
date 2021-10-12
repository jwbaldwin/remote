defmodule Remote.RemoteServerTest do
  use Remote.DataCase

  alias Remote.RemoteServer

  describe "init/1" do
    test "starts with the correct initial state" do
      initial_state = %RemoteServer.State{max_number: 99, timestamp: nil}

      assert RemoteServer.init(initial_state) ==
               {:ok, %RemoteServer.State{max_number: 99, timestamp: nil}}
    end
  end

  describe "handle_call/3" do
    test "subsequent calls should return a timestmap" do
      {:ok, _} = RemoteServer.find_users()
      {:ok, %{timestamp: timestamp, users: users}} = RemoteServer.find_users()

      assert timestamp != nil
      assert users == []
    end
  end

  describe "handle_info/3" do
    test "schedules update for the server" do
      state = %RemoteServer.State{max_number: 0, timestamp: nil}
      RemoteServer.handle_info(:update_server, state)

      assert_receive :update_server, 2_000
    end
  end
end
