defmodule Encryption.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Encryption.{User, HashField, PasswordField, EncryptedField}

  schema "users" do
    field :email, EncryptedField
    field :email_hash, HashField
    field :name, EncryptedField
    field :password_hash, PasswordField

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:email])
    |> add_email_hash
    |> unique_constraint(:email_hash)
  end

  defp add_email_hash(changeset) do
    if Map.has_key?(changeset.changes, :email) do
      changeset |> put_change(:email_hash, changeset.changes.email)
    else
      changeset
    end
  end
end
