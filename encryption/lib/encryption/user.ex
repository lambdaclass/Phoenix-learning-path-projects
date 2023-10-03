defmodule Encryption.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :binary
    field :email, :binary
    field :email_hash, :binary
    field :password_hash, :binary

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :email_hash, :name, :password_hash])
    |> validate_required([:email, :email_hash, :name, :password_hash])
  end
end
