defmodule RepoListWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :repo_list

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug RepoListWeb.Auth.RefreshToken
end
