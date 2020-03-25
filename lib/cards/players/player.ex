defmodule Cards.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "players" do
    field :id, :id
    belongs_to :user, Cards.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [:id, :user_id])
    |> validate_required([:id, :user_id])
  end
end
