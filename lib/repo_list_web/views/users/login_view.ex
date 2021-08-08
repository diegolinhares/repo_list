defmodule RepoListWeb.Views.Users.LoginView do
  use RepoListWeb, :view

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
