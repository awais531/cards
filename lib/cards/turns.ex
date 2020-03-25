defmodule Cards.Turns do
  @moduledoc """
  The Turns context.
  """

  import Ecto.Query, warn: false
  alias Cards.Repo

  alias Cards.Turns.Turn

  @doc """
  Returns the list of turns.

  ## Examples

      iex> list_turns()
      [%Turn{}, ...]

  """
  def list_turns do
    Repo.all(Turn)
  end

  @doc """
  Gets a single turn.

  Raises `Ecto.NoResultsError` if the Turn does not exist.

  ## Examples

      iex> get_turn!(123)
      %Turn{}

      iex> get_turn!(456)
      ** (Ecto.NoResultsError)

  """
  def get_turn!(id), do: Repo.get!(Turn, id)

  @doc """
  Creates a turn.

  ## Examples

      iex> create_turn(%{field: value})
      {:ok, %Turn{}}

      iex> create_turn(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_turn(attrs \\ %{}) do
    %Turn{}
    |> Turn.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a turn.

  ## Examples

      iex> update_turn(turn, %{field: new_value})
      {:ok, %Turn{}}

      iex> update_turn(turn, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_turn(%Turn{} = turn, attrs) do
    turn
    |> Turn.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Turn.

  ## Examples

      iex> delete_turn(turn)
      {:ok, %Turn{}}

      iex> delete_turn(turn)
      {:error, %Ecto.Changeset{}}

  """
  def delete_turn(%Turn{} = turn) do
    Repo.delete(turn)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking turn changes.

  ## Examples

      iex> change_turn(turn)
      %Ecto.Changeset{source: %Turn{}}

  """
  def change_turn(%Turn{} = turn) do
    Turn.changeset(turn, %{})
  end
end
