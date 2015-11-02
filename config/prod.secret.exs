use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :redirect_to, RedirectTo.Endpoint,
  secret_key_base: "PnBgDWyFmWrlBBLHcAxThcx8/vKbhc7TLI4UHC7RSSZo1XmmDd09wmGjJq7/uO69"

# Configure your database
config :redirect_to, RedirectTo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "redirect_to_prod",
  pool_size: 20
