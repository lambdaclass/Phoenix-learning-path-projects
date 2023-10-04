defmodule Encryption.AESTest do
  use ExUnit.Case
  alias Encryption.AES

  test ".encrypt includes the random IV in the value" do
    <<iv::binary-16, ciphertext::binary>> = AES.encrypt("hello")

    assert String.length(iv) != 0
    assert String.length(ciphertext) != 0
    assert is_binary(ciphertext)
  end

  test ".encrypt does not produce the same ciphertext twice" do
    assert AES.encrypt("hello") != AES.encrypt("hello")
  end

  test "decrypt/1 ciphertext that was encrypted with default key" do
    plaintext = "hello" |> AES.encrypt |> AES.decrypt()
    assert plaintext == "hello"
  end

  test "can still decrypt the value after adding a new encryption key" do
    encrypted_value = "hello" |> AES.encrypt()

    original_keys = Application.get_env(:encryption, Encryption.AES)[:keys]

    # add a new key
    Application.put_env(:encryption, Encryption.AES,
      keys: original_keys ++ [:crypto.strong_rand_bytes(32)]
    )

    assert "hello" == encrypted_value |> AES.decrypt()

    # rollback to the original keys
    Application.put_env(:encryption, Encryption.AES, keys: original_keys)
  end
end
