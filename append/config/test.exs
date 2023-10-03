import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :append, Append.Repo,
  migration_timestamps: [type: :naive_datetime_usec],
  username: "append_only",
  password: "postgres",
  hostname: "localhost",
  database: "append_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :append, AppendWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "GQCeDLJqX/o2o3ewAPXnc/+dPAEj6nBos4o23MYpqK08jbaF9Si3uHcM9fWB4qe2",
  server: false

# In test we don't send emails.
config :append, Append.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
