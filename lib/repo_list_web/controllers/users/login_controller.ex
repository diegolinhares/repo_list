defmodule RepoListWeb.Users.LoginController do
  use RepoListWeb, :controller

  alias RepoListWeb.{Auth.Guardian, FallbackController, Views.Users.LoginView}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_view(LoginView)
      |> render("sign_in.json", token: token)
    end
  end
end
