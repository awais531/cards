defmodule Cards.Hands do
  @moduledoc """
  The Hands context.
  """

  import Ecto.Query, warn: false
  alias Cards.Repo

  alias Cards.Hands.Hand

  @doc """
  Returns the list of hands.

  ## Examples

      iex> list_hands()
      [%Hand{}, ...]

  """
  def list_hands do
    Repo.all(Hand)
  end

  @doc """
  Gets a single hand.

  Raises `Ecto.NoResultsError` if the Hand does not exist.

  ## Examples

      iex> get_hand!(123)
      %Hand{}

      iex> get_hand!(456)
      ** (Ecto.NoResultsError)

  """
  def get_hand!(id), do: Repo.get!(Hand, id)

  @doc """
  Creates a hand.

  ## Examples

      iex> create_hand(%{field: value})
      {:ok, %Hand{}}

      iex> create_hand(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_hand(attrs \\ %{}) do
    %Hand{}
    |> Hand.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a hand.

  ## Examples

      iex> update_hand(hand, %{field: new_value})
      {:ok, %Hand{}}

      iex> update_hand(hand, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_hand(%Hand{} = hand, attrs) do
    hand
    |> Hand.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Hand.

  ## Examples

      iex> delete_hand(hand)
      {:ok, %Hand{}}

      iex> delete_hand(hand)
      {:error, %Ecto.Changeset{}}

  """
  def delete_hand(%Hand{} = hand) do
    Repo.delete(hand)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking hand changes.

  ## Examples

      iex> change_hand(hand)
      %Ecto.Changeset{source: %Hand{}}

  """
  def change_hand(%Hand{} = hand) do
    Hand.changeset(hand, %{})
  end
end
