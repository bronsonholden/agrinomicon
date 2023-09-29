defmodule Agrinomicon.Production do
  @moduledoc """
  The Production context.
  """

  import Ecto.Query, warn: false
  alias Agrinomicon.Repo

  alias Agrinomicon.Production.Tenure

  @doc """
  Returns the list of tenures.

  ## Examples

      iex> list_tenures()
      [%Tenure{}, ...]

  """
  def list_tenures do
    Repo.all(Tenure)
  end

  @doc """
  Gets a single tenure.

  Raises `Ecto.NoResultsError` if the Tenure does not exist.

  ## Examples

      iex> get_tenure!(123)
      %Tenure{}

      iex> get_tenure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tenure!(id), do: Repo.get!(Tenure, id)

  def get_tenure!(id, preloads: preloads), do: Repo.get!(Tenure, id) |> Repo.preload(preloads)

  @doc """
  Creates a tenure.

  ## Examples

      iex> create_tenure(%{field: value})
      {:ok, %Tenure{}}

      iex> create_tenure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tenure(attrs \\ %{}) do
    %Tenure{}
    |> Tenure.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tenure.

  ## Examples

      iex> update_tenure(tenure, %{field: new_value})
      {:ok, %Tenure{}}

      iex> update_tenure(tenure, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tenure(%Tenure{} = tenure, attrs) do
    tenure
    |> Tenure.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tenure.

  ## Examples

      iex> delete_tenure(tenure)
      {:ok, %Tenure{}}

      iex> delete_tenure(tenure)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tenure(%Tenure{} = tenure) do
    Repo.delete(tenure)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tenure changes.

  ## Examples

      iex> change_tenure(tenure)
      %Ecto.Changeset{data: %Tenure{}}

  """
  def change_tenure(%Tenure{} = tenure, attrs \\ %{}) do
    Tenure.changeset(tenure, attrs)
  end

  alias Agrinomicon.Production.Distribution

  @doc """
  Returns the list of distributions.

  ## Examples

      iex> list_distributions()
      [%Distribution{}, ...]
      iex> list_distributions(%{"tenure_id" => "009a6407-8721-452d-aea3-c0574f335c57"})
      [%Distribution{}, ...]

  """
  def list_distributions(), do: list_distributions(%{})

  def list_distributions(%{"tenure_id" => tenure_id}) do
    query = from d in Distribution, where: d.tenure_id == ^tenure_id
    Repo.all(query)
  end

  def list_distributions(_) do
    Repo.all(Distribution)
  end

  @doc """
  Gets a single distribution.

  Raises `Ecto.NoResultsError` if the Distribution does not exist.

  ## Examples

      iex> get_distribution!(123)
      %Distribution{}

      iex> get_distribution!(456)
      ** (Ecto.NoResultsError)

  """
  def get_distribution!(id), do: Repo.get!(Distribution, id)

  @doc """
  Creates a distribution.

  ## Examples

      iex> create_distribution(%{field: value})
      {:ok, %Distribution{}}

      iex> create_distribution(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_distribution(attrs \\ %{}) do
    %Distribution{}
    |> Distribution.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a distribution.

  ## Examples

      iex> update_distribution(distribution, %{field: new_value})
      {:ok, %Distribution{}}

      iex> update_distribution(distribution, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_distribution(%Distribution{} = distribution, attrs) do
    distribution
    |> Distribution.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a distribution.

  ## Examples

      iex> delete_distribution(distribution)
      {:ok, %Distribution{}}

      iex> delete_distribution(distribution)
      {:error, %Ecto.Changeset{}}

  """
  def delete_distribution(%Distribution{} = distribution) do
    Repo.delete(distribution)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking distribution changes.

  ## Examples

      iex> change_distribution(distribution)
      %Ecto.Changeset{data: %Distribution{}}

  """
  def change_distribution(%Distribution{} = distribution, attrs \\ %{}) do
    Distribution.changeset(distribution, attrs)
  end
end
