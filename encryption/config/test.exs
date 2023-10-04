import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :encryption, Encryption.Repo,
  username: "theo",
  password: "1t8j1j1",
  hostname: "localhost",
  database: "encryption_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :encryption, EncryptionWeb.Endpoint,
  http: [port: 4001],
  server: false,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# In test we don't send emails.
config :encryption, Encryption.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
