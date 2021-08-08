defmodule RepoListWeb.Auth.RefreshToken do
  import Plug.Conn

  alias RepoListWeb.Auth.Guardian
  alias Plug.Conn

  def init(default), do: default

  def call(%Conn{} = conn, _default) do
    authorization_header = Conn.get_req_header(conn, "authorization")

    ["Bearer " <> token] = authorization_header

    {:ok, _old_stuff, {new_token, _new_claims}} = Guardian.refresh_token_for_one_minute(token)

    conn |> put_private(:token, new_token)
  end
end
