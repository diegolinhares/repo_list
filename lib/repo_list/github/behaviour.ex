defmodule RepoList.Github.Behaviour do
  alias RepoList.Github.Error

  # Defining the types
  @typep username :: String.t()
  @typep github_client_result :: {:ok, map()} | {:error, Error.t()}

  @callback get_user_repos(username) :: github_client_result
end
