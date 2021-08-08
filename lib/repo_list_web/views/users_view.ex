defmodule RepoListWeb.UsersView do
  use RepoListWeb, :view

  alias RepoList.User

  def render("create.json", %{user: %User{} = user, token: token}) do
    %{message: "User created!", user: user, token: token}
  end
end
