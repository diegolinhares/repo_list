defmodule RepoList.Users.Repos.Get do
  def call(username), do: client().get_user_repos(username)

  defp client do
    Application.fetch_env!(:repo_list, __MODULE__)[:github_adapter]
  end
end
