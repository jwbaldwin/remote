defmodule RemoteWeb.UserControllerTest do
  use RemoteWeb.ConnCase

  import Remote.UsersFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index route" do
    test "returns no users when no users meet the criteria", %{conn: conn} do
      _users = multi_user_fixture(3, [%{points: 0}, %{points: 0}, %{points: 0}])

      conn = get(conn, Routes.user_path(conn, :index))
      response = json_response(conn, 200)

      assert response["users"] == []
    end

    test "returns one user when only one user meets the criteria", %{conn: conn} do
      [user | _] = multi_user_fixture(3, [%{points: 100}, %{points: 0}, %{points: 0}])

      conn = get(conn, Routes.user_path(conn, :index))
      response = json_response(conn, 200)
      assert response["users"] == [%{"points" => user.points, "id" => user.id}]
    end
  end
end
