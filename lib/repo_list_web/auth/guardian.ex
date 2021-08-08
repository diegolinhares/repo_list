defmodule RepoListWeb.Auth.Guardian do
  use Guardian, otp_app: :repo_list

  alias RepoList.{Error, User}

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, id}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> RepoList.get_user_by_id()
  end

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: password_hash} = user} <- RepoList.get_user_by_id(user_id),
         true <- Pbkdf2.verify_pass(password, password_hash),
         {:ok, token, _claims} <- generate_token_for_one_minute(user) do
      {:ok, token}
    else
      false -> {:error, Error.build_unauthorized()}
      error -> error
    end
  end

  def authenticate(_), do: {:error, Error.invalid_or_missing_params()}

  def generate_token_for_one_minute(resource) do
    encode_and_sign(resource, %{}, ttl: {1, :minute})
  end

  def refresh_token_for_one_minute(token) do
    refresh(token, ttl: {1, :minute})
  end
end
