defmodule Remote.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Remote.Users` context.
  """

  @doc """
  Generates n amounts of users with the option to provide attrs (must be provided in order)

  ## Examples


    iex> multi_user_fixture(2)
    [%User{}, %User{}]

    iex> multi_user_fixture(3, [%{points: 1}, %{points: 2}, %{points: 3}])
    [%User{..., points: 1}, %User{..., points: 2}, %User{..., points: 3}]
  """
  def multi_user_fixture(number_of_users, attrs \\ []) do
    for i <- 0..(number_of_users - 1) do
      user_fixture(Enum.at(attrs, i, %{}))
    end
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        points: 42
      })
      |> Remote.Users.create_user()

    user
  end
end
