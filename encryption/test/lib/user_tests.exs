defmodule Encryption.UserTest do
  use Encryption.DataCase
  alias Encryption.User

  @valid_attrs %{
    name: "Max",
    email: "max@example.com",
    password: "NoCarbsBeforeMarbs"
  }

  @invalid_attrs %{}

  describe "Verify correct working of hashing" do
    setup do
      user = Repo.insert!(User.changeset(%User{}, @valid_attrs))
      {:ok, user: user, email: @valid_attrs.email}
    end

    test "inserting a user sets the :email_hash field", %{user: user} do
      assert user.email_hash == user.email
    end

    test ":email_hash field is the encrypted hash of the email", %{user: user} do
      user_from_db = User |> Repo.one()
      assert user_from_db.email_hash == Encryption.HashField.hash(user.email)
    end
  end
end
