defmodule Agrinomicon.Taxonomy do
  @moduledoc """
  The Taxonomy context.
  """

  import Ecto.Query, warn: false
  alias Agrinomicon.Repo

  alias Agrinomicon.Taxonomy.Classification

  @doc """
  Returns the list of classifications.

  ## Examples

      iex> list_classifications()
      [%Classification{}, ...]

  """
  def list_classifications(), do: list_classifications(Classification)

  @doc """
  Returns the list of classifications within the given query.

  ## Examples

      iex> list_classifications()
      [%Classification{}, ...]

  """
  def list_classifications(query) do
    Repo.all(query)
  end

  @doc """
  Gets a single classification.

  Raises `Ecto.NoResultsError` if the Classification does not exist.

  ## Examples

      iex> get_classification!(123)
      %Classification{}

      iex> get_classification!(456)
      ** (Ecto.NoResultsError)

  """
  def get_classification!(id) do
    Repo.get!(Classification, id)
  rescue
    Ecto.Query.CastError -> nil
  end

  @doc """
  Gets a single classification by binomial name (case sensitive).

  Raises `Ecto.NoResultsError` if the Classification does not exist.

  ## Examples

      iex> get_classification_by_binomial_name!("Vitis vinifera")
      %Classification{}

      iex> get_classification_by_binomial_name!("Homo neanderthalensis")
      ** (Ecto.NoResultsError)

  """
  def get_classification_by_binomial_name!(binomial_name) do
    Repo.get_by!(Classification, binomial_name: binomial_name)
  rescue
    Ecto.Query.CastError -> nil
  end

  @doc """
  Gets a single classification by its assigned USDA CDL value. Values range from 1-255.

  Returns `nil` if no such Classification was found.

  ## Examples

      iex> get_classification_by_cdl_value(1)
      %Classification{}

      iex> get_classification_by_cdl_value(0)
      nil

  """
  def get_classification_by_cdl_value(cdl_value) when is_integer(cdl_value),
    do: get_classification_by_cdl_value(to_string(cdl_value))

  def get_classification_by_cdl_value(cdl_value),
    do: Repo.get_by(Classification, cdl_value: cdl_value)

  @doc """
  Creates a classification.

  ## Examples

      iex> create_classification(%{field: value})
      {:ok, %Classification{}}

      iex> create_classification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_classification(attrs \\ %{}) do
    %Classification{}
    |> Classification.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a classification.

  ## Examples

      iex> update_classification(classification, %{field: new_value})
      {:ok, %Classification{}}

      iex> update_classification(classification, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_classification(%Classification{} = classification, attrs) do
    classification
    |> Classification.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a classification.

  ## Examples

      iex> delete_classification(classification)
      {:ok, %Classification{}}

      iex> delete_classification(classification)
      {:error, %Ecto.Changeset{}}

  """
  def delete_classification(%Classification{} = classification) do
    Repo.delete(classification)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking classification changes.

  ## Examples

      iex> change_classification(classification)
      %Ecto.Changeset{data: %Classification{}}

  """
  def change_classification(%Classification{} = classification, attrs \\ %{}) do
    Classification.changeset(classification, attrs)
  end

  alias Agrinomicon.Taxonomy.Variety

  @doc """
  Returns the list of varieties.

  ## Examples

      iex> list_varieties()
      [%Variety{}, ...]

  """
  def list_varieties([preloads: preloads] = _) do
    list_varieties() |> Repo.preload(preloads)
  end

  @doc """
  Returns the list of varieties.

  ## Examples

      iex> list_varieties()
      [%Variety{}, ...]

  """
  def list_varieties do
    Repo.all(Variety)
  end

  @doc """
  Gets a single variety with preloaded associations

  Raises `Ecto.NoResultsError` if the Variety does not exist.

  ## Examples

      iex> get_variety!(123, preloads: [:classification])
      %Variety{}

      iex> get_variety!(456, preloads: [:classification])
      ** (Ecto.NoResultsError)

  """
  def get_variety!(id, [preloads: preloads] = _), do: get_variety!(id) |> Repo.preload(preloads)

  @doc """
  Gets a single variety.

  Raises `Ecto.NoResultsError` if the Variety does not exist.

  ## Examples

      iex> get_variety!(123)
      %Variety{}

      iex> get_variety!(456)
      ** (Ecto.NoResultsError)

  """
  def get_variety!(id), do: Repo.get!(Variety, id)

  @doc """
  Creates a variety.

  ## Examples

      iex> create_variety(%{field: value})
      {:ok, %Variety{}}

      iex> create_variety(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_variety(attrs \\ %{}) do
    %Variety{}
    |> Variety.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a variety.

  ## Examples

      iex> update_variety(variety, %{field: new_value})
      {:ok, %Variety{}}

      iex> update_variety(variety, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_variety(%Variety{} = variety, attrs) do
    variety
    |> Variety.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a variety.

  ## Examples

      iex> delete_variety(variety)
      {:ok, %Variety{}}

      iex> delete_variety(variety)
      {:error, %Ecto.Changeset{}}

  """
  def delete_variety(%Variety{} = variety) do
    Repo.delete(variety)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking variety changes.

  ## Examples

      iex> change_variety(variety)
      %Ecto.Changeset{data: %Variety{}}

  """
  def change_variety(%Variety{} = variety, attrs \\ %{}) do
    Variety.changeset(variety, attrs)
  end
end
