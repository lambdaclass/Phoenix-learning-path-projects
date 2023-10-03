defmodule Append.AppendOnlyLog do
  alias Append.Repo
  require Ecto.Query

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
      import Ecto.Query

      def insert(attrs) do
        %__MODULE__{}
        |> __MODULE__.changeset(attrs)
        |> Repo.insert()
      end

      def get(entry_id) do
        query =
          from(
            m in __MODULE__,
            where: m.entry_id == ^entry_id,
            order_by: [desc: :inserted_at],
            limit: 1,
            select: m
          )

        Repo.one(query)
      end

      def all do
        query =
          from(m in __MODULE__,
            distinct: m.entry_id,
            order_by: [desc: :inserted_at],
            select: m
          )

        Repo.all(query)
      end

      def update(%__MODULE__{} = item, attrs) do
        item
        |> Map.put(:id, nil)
        |> Map.put(:inserted_at, nil)
        |> Map.put(:updated_at, nil)
        |> __MODULE__.changeset(attrs)
        |> Repo.insert()
      end
    end
  end
end
