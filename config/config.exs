# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :notyerbot,
  ecto_repos: [Notyerbot.Repo]

# Configures the endpoint
config :notyerbot, NotyerbotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BlCDk+z+ExoKR46CFsGTcZ+sMOF+lGqpHKoMdgHBbDMjWz9oE72o2mSCBgLhChnf",
  render_errors: [view: NotyerbotWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Notyerbot.PubSub,
  live_view: [signing_salt: "E6xVcbU4"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
