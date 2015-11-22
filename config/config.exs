# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :redirect_to, RedirectTo.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "em53R9QVk2x4MzXEpLVarykJqpm7QEkRUYgzs48U/JTkRYEj7IpUD9YIeVWv2qRC",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: RedirectTo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :hound, driver: "phantomjs"
config :ua_inspector,
  database_path: Path.join(Path.expand("priv/repo"), "ua_inspector")

  config :geolix,
  databases: [
    { :city,    Path.join(Path.expand("priv/repo/geoip"), "GeoLite2-City.mmdb.gz")    },
    { :country, Path.join(Path.expand("priv/repo/geoip"), "GeoLite2-Country.mmdb.gz") }
  ]
