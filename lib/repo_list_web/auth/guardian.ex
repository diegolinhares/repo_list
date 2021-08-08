defmodule RepoListWeb.Auth.Guardian do
  use Guardian, otp_app: :repo_list

  alias RepoList.User

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, id}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> RepoList.get_user_by_id()
  end
end
