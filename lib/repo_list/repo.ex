defmodule RepoList.Repo do
  use Ecto.Repo,
    otp_app: :repo_list,
    adapter: Ecto.Adapters.Postgres
end
