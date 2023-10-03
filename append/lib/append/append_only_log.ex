defmodule Append.AppendOnlyLog do
  alias Append.Repo

  @callback insert(struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  @callback get(integer) :: Ecto.Schema.t() | nil | no_return()
  @callback all() :: [Ecto.Schema.t()]
  @callback update(Ecto.Schema.t(), struct) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  @callback delete(Ecto.Schema.t()) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  defmacro __using__(_opts) do
    quote do
      @behaviour Append.AppendOnlyLog

      def insert(attrs) do
      end

      def get(id) do
      end

      def all() do
      end

      def update(item, attrs) do
      end
    end
  end
end
