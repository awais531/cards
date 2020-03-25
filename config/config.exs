# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cards,
  ecto_repos: [Cards.Repo]

# Configures the endpoint
config :cards, CardsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UnGVAq/88Lkto0mI4+INq+YkKpLazmMtYskT3tZVlC5YFxjAe7nKGSnQA1ADBzCO",
  render_errors: [view: CardsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cards.PubSub, adapter: Phoenix.PubSub.PG2]


config :cards, Cards.UserManager.Guardian,
       issuer: "cards",
       secret_key: "oK1S+Bkcifq125XoztCMXKh+mxxvi5Pn289J1umtSAYx5k1+tokSI7ihbXIwYxOA"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :exq,
       host: "127.0.0.1",
       port: 6379,
       namespace: "exq",
       concurrency: 1000,
       queues: ["default", "start_game"],
       scheduler_enable: true

config :exq_ui,
       server: true
# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
