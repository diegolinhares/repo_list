defmodule RepoList.Users.Repos.Get do
  alias RepoList.Github.Client

  def call(username), do: Client.get_user_repos(username)
end
