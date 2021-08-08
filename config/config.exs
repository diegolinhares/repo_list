# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :repo_list, RepoList.Users.Repos.Get, github_adapter: RepoList.Github.Client

config :repo_list,
       RepoList.Auth.Guardian,
       issuer: "repo_list",
       secret_key: "1BlSS9ZTM6XH6Xmu2It15H3dLVYYkyKUWKDVT3/TrwLOO2cTIeBmx008D8tHBoWl"

config :repo_list,
  ecto_repos: [RepoList.Repo]

# Configures the endpoint
config :repo_list, RepoListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0VyzHJp9boIvD1bNBSK63++7fm2kAjJXSe4mGvecuswdmq6ho0YTMwPayaSg4dr2",
  render_errors: [view: RepoListWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: RepoList.PubSub,
  live_view: [signing_salt: "fAWjSbhj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
