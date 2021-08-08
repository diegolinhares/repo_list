defmodule RepoList.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:password]

  @derive {Jason.Encoder, only: [:id] ++ @required_fields}

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> validate_length(:password, min: 12)
  end
end
