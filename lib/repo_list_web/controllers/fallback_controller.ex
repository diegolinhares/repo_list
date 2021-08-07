defmodule RepoListWeb.FallbackController do
  use RepoListWeb, :controller

  alias RepoListWeb.ErrorView

  def call(conn, {:error, error}) do
    conn
    |> put_status(error.status)
    |> put_view(ErrorView)
    |> render("error.json", result: error)
  end
end
