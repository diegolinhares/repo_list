defmodule RepoListWeb.UserReposController do
  use RepoListWeb, :controller

  alias RepoListWeb.FallbackController

  action_fallback FallbackController

  def show(conn, %{"username" => username}) do
    with {:ok, repos} <- RepoList.get_user_repos(username) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos)
    end
  end
end
