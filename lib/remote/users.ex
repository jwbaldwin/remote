defmodule Remote.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Remote.Repo
  alias Remote.Time
  alias Remote.Users.User

  @doc """
  Returns all users with :points greater than max_number.
  Accepts an optional second parameter for how many results to return. Default is 2.

  ## Examples

      iex> find_users(max_number)
      [%User{}, %User{}]

      iex> find_users(max_number, 1)
      [%User{}]

  """
  @spec find_users(pos_integer(), any) :: any
  def find_users(max_number, results_limit \\ 2) do
    User
    |> where([u], u.points > ^max_number)
    |> limit(^results_limit)
    |> Repo.all()
  end

  @doc """
  Updates all users with a random :points number (1..100).

  ## Examples

      iex> update_all_users()
      {1000000, nil}
  """
  def update_all_users() do
    now = Time.utc_now()

    User
    |> update(set: [points: fragment("floor(random() * 101)"), updated_at: ^now])
    |> Repo.update_all([])
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
