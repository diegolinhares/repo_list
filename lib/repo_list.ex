defmodule RepoList do
  alias RepoList.Users.Repos.Get, as: UserGetRepos
  alias RepoList.Users.Get, as: UserGet

  defdelegate get_user_repos(username), to: UserGetRepos, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
end
