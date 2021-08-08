defmodule RepoList.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @required_fields [:password]

  @derive {Jason.Encoder, only: [:id]}

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 12)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
