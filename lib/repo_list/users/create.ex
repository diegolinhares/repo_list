defmodule RepoList.Users.Create do
  alias RepoList.{Repo, User, Error}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = user), do: user

  defp handle_insert({:error, result}) do
    {:error, Error.build(result, :bad_request)}
  end
end
