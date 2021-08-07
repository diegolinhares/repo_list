defmodule RepoList.Users.Repos.Get do
  def call(username), do: client().get_user_repos(username)

  defp client do
    :repo_list
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:github_adapter)
  end
end
