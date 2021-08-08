defmodule RepoListWeb.Router do
  use RepoListWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug RepoListWeb.Auth.Pipeline
  end

  scope "/api", RepoListWeb do
    pipe_through [:api, :auth]

    resources "/user_repos", UserReposController, param: "username", only: [:show]
  end

  scope "/api", RepoListWeb do
    pipe_through :api

    resources "/users", UsersController, only: [:create]

    scope "/users" do
      resources "/login", Users.LoginController, only: [:create], as: :users_login
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: RepoListWeb.Telemetry
    end
  end
end
