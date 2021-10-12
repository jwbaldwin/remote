defmodule Remote.Users.User do
  use Remote.Db.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          id: integer,
          points: number,
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "users" do
    field(:points, :integer)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> validate_number(:points, greater_than_or_equal_to: 0)
    |> validate_number(:points, less_than_or_equal_to: 100)
  end
end
