defmodule RepoListWeb.Users.LoginControllerTest do
  use RepoListWeb.ConnCase, async: true

  describe "create/2" do
    test "when the params are valid, returns the auth token", %{conn: conn} do
      # Arrange
      params = %{"password" => "123456789101112"}

      {:ok, user} = RepoList.create_user(params)

      params = Map.merge(params, %{id: user.id})

      # Act
      response =
        conn
        |> post(Routes.users_login_path(conn, :create, params))
        |> json_response(:ok)

      # Assert
      assert %{
               "token" => _token
             } = response
    end

    test "when the params are invalid, returns an error", %{conn: conn} do
      # Arrange
      params = %{"password" => "123456"}

      # Act
      response =
        conn
        |> post(Routes.users_login_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid or missing params"}

      # Assert
      assert response == expected_response
    end
  end
end
