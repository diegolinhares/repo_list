defmodule RepoList do
  alias RepoList.Users.Repos.Get, as: UserGetRepos
  alias RepoList.Users.Get, as: UserGet
  alias RepoList.Users.Create, as: UserCreate

  defdelegate get_user_repos(username), to: UserGetRepos, as: :call
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id
  defdelegate create_user(params), to: UserCreate, as: :call
end
