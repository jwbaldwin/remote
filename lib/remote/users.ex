defmodule Remote.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Remote.Repo

  alias Remote.Users.User

  @doc """
  Returns all users with :points greater than max_number
  Accepts an optional second parameter for how many results to return. Default is 2

  ## Examples

      iex> find_users(max_number)
      [%User{}, %User{}]

      iex> find_users(max_number, 1)
      [%User{}]

  """
  def find_users(max_number, results_limit \\ 2) do
    User
    |> where([u], u.points > ^max_number)
    |> limit(^results_limit)
    |> Repo.all()
  end

  @doc """
  Updates all users with a random :points number (1..100)

  ## Examples

      iex> update_all_users()
      {:ok, 1000000}
  """
  def update_all_users() do
    User
    |> update(set: [points: fragment("floor(random() * 100)")])
    |> Repo.update_all([])
    |> IO.inspect()
  end

  @doc """
  Creates a user.
  ## Examples
      iex> create_user(%{field: value})
      {:ok, %User{}}
      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
