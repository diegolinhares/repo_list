defmodule RepoList do
  alias RepoList.Users.Repos.Get, as: UserGetRepos

  defdelegate get_user_repos(username), to: UserGetRepos, as: :call
end
