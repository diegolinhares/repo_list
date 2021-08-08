defmodule RepoList.Github.Client do
  use Tesla

  plug Tesla.Middleware.Headers, [{"user-agent", "RepoListTesla"}]
  plug Tesla.Middleware.JSON

  alias RepoList.Github.{Behaviour, Repo}
  alias RepoList.Error
  alias Tesla.Env

  @behaviour Behaviour

  @base_url "https://api.github.com/users/"

  @spec get_user_repos(any, any) :: {:error, any} | {:ok, list}
  def get_user_repos(url \\ @base_url, username) do
    "#{url}#{username}/repos"
    |> get()
    |> handle_response()
  end

  defp handle_response({:ok, %Env{status: 200} = response}) do
    {:ok, Enum.map(response.body, &build_repo_response/1)}
  end

  defp handle_response({:ok, %Env{status: 404} = response}) do
    {:error, Error.build(response.body["message"], :bad_request)}
  end

  defp build_repo_response(repo) do
    Repo.build(
      repo["id"],
      repo["name"],
      repo["description"],
      repo["html_url"],
      repo["stargazers_count"]
    )
  end
end
