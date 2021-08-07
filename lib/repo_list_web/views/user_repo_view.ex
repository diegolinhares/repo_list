defmodule RepoListWeb.UserReposView do
  use RepoListWeb, :view

  def render("repos.json", %{repos: repos}) do
    %{repos: repos}
  end
end
