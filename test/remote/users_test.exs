defmodule Remote.UsersTest do
  use Remote.DataCase

  alias Remote.Users

  describe "users" do
    alias Remote.Users.User

    import Remote.UsersFixtures

    test "find_users/1 returns two users when exactly two users have points greater than max_number" do
      [_user_1, user_2, user_3] =
        multi_user_fixture(3, [%{points: 1}, %{points: 2}, %{points: 3}])

      max_number = 1

      assert Users.find_users(max_number) == [user_2, user_3]
    end

    test "find_users/1 no users when no user has points greater than max_number" do
      _users = multi_user_fixture(3, [%{points: 1}, %{points: 2}, %{points: 3}])
      max_number = 4

      assert Users.find_users(max_number) == []
    end

    test "find_users/1 returns one user when only one has points greater than max_number" do
      [user_1 | _] = multi_user_fixture(3, [%{points: 100}, %{points: 0}, %{points: 0}])
      max_number = 99

      assert Users.find_users(max_number) == [user_1]
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{points: 42}

      assert {:ok, %User{} = user} = Users.create_user(valid_attrs)
      assert user.points == 42
    end

    test "create_user/1 with points greater than 100 returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(%{points: 101})
    end
  end
end
