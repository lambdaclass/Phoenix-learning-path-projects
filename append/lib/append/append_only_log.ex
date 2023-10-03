defmodule Append.AppendOnlyLog do
  alias Append.Repo

  @callback insert(struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  @callback get(integer) :: Ecto.Schema.t() | nil | no_return()
  @callback all() :: [Ecto.Schema.t()]
  @callback update(Ecto.Schema.t(), struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  @callback delete(Ecto.Schema.t()) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  defmacro __using__(_opts) do
    quote location: :keep do
      @behaviour Append.AppendOnlyLog
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_env) do
    quote do
      def insert(attrs) do
        %__MODULE__{}
        |> __MODULE__.changeset(attrs)
        |> Repo.insert()
      end

      def get(id) do
        Repo.get(__MODULE__, id)
      end

      def all do
        Repo.all(__MODULE__)
      end

      def update(item, attrs) do
      end
    end
  end
end
