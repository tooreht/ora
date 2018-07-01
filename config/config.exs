# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ora,
  ecto_repos: [Ora.Repo]

# Configures the endpoint
config :ora, OraWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "O1qhrmhvhq2JOXvREm6HrbkJdnRvOFA4kn0tpvjzXes52zqa7eN9h8I0qcEq5ZfM",
  render_errors: [view: OraWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ora.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Ora.Accounts.User,
  repo: Ora.Repo,
  module: Ora,
  web_module: OraWeb,
  router: OraWeb.Router,
  messages_backend: OraWeb.Coherence.Messages,
  logged_out_url: "/sessions/new",
  user_active_field: true,
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:rememberable, :authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, OraWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
