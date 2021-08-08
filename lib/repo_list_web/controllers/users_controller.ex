defmodule RepoListWeb.UsersController do
  use RepoListWeb, :controller

  alias RepoList.User
  alias RepoListWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- RepoList.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:ok)
      |> render("create.json", user: user, token: token)
    end
  end
end