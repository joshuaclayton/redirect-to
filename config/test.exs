use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :redirect_to, RedirectTo.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :redirect_to, RedirectTo.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "redirect_to_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
