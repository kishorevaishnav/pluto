# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pluto,
  ecto_repos: [Pluto.Repo]

# Configures the endpoint
config :pluto, Pluto.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "x6hym0A67nJlWpHpcclHEvCjjkC2WowE7pF8SGl50wVfUavF7gYR9cVr1lfg97+5",
  render_errors: [view: Pluto.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pluto.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
