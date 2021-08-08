defmodule RepoListWeb.UsersControllerTest do
  use RepoListWeb.ConnCase, async: true

  describe "create/2" do
    test "when the params are valid, creates the user and an auth token", %{conn: conn} do
      # Arrange
      params = %{"password" => "123456789101112"}

      # Act
      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:ok)

      # Assert
      assert %{
               "message" => "User created!",
               "token" => _token,
               "user" => %{"id" => _id}
             } = response
    end

    test "when the params are invalid, returns an error", %{conn: conn} do
      # Arrange
      params = %{"password" => "123456"}

      # Act
      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{"password" => ["should be at least %{count} character(s)"]}
      }

      # Assert
      assert response == expected_response
    end
  end
end
