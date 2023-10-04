defmodule Encryption.AES do
  @aad "AES256GCM" # Use AES 256 Bit Keys for Encryption.

  def encrypt(plaintext) do
    iv = :crypto.strong_rand_bytes(16)
    # get latest key
    key = get_key()
    # get latest ID;
    key_id = get_key_id()

    {ciphertext, tag} = :crypto.crypto_one_time_aead(:aes_256_gcm, key, iv, plaintext, @aad, true)
    iv <> tag <> <<key_id::unsigned-big-integer-32>> <> ciphertext
  end

  def decrypt(ciphertext) do
    <<iv::binary-16, tag::binary-16, key_id::unsigned-big-integer-32, ciphertext::binary>> =
      ciphertext
    :crypto.crypto_one_time_aead(:aes_256_gcm, get_key(key_id), iv, ciphertext, @aad, tag, false)
  end

  defp get_key do
    get_key_id() |> get_key
  end

  defp get_key(key_id) do
    encryption_keys() |> Enum.at(key_id)
  end

  defp get_key_id do
    Enum.count(encryption_keys()) - 1
  end

  defp encryption_keys do
    Application.get_env(:encryption, Encryption.AES)[:keys]
  end
end
