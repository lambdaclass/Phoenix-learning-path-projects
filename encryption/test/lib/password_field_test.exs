defmodule Encryption.PasswordFieldTest do
  use ExUnit.Case
  alias Encryption.PasswordField, as: Field

  test ".verify_password checks the password against the Argon2id Hash" do
    password = "EverythingisAwesome"
    hash = Field.hash_password(password)
    verified = Argon2.verify_pass(password, hash)
    assert verified
  end

  test ".verify_password fails if password does NOT match hash" do
    password = "EverythingisAwesome"
    hash = Field.hash_password(password)
    verified = Field.verify_password("LordBusiness", hash)
    assert !verified
  end
end
