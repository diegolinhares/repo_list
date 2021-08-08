defmodule RepoListWeb.UserReposControllerTest do
  use RepoListWeb.ConnCase, async: true

  import Mox

  alias RepoList.Github.{ClientMock, Repo}
  alias RepoList.Error

  describe "show/2" do
    test "when the user exists and has repos, it returns his repos", %{conn: conn} do
      # Arrange
      username = "danilo-vieira"

      expect(ClientMock, :get_user_repos, fn _username ->
        {:ok,
         [
           %Repo{
             id: 247_000_001,
             name: "audio_processing",
             html_url: "https://github.com/danilo-vieira/audio_processing",
             description:
               "Material necessário para realização do processamento de áudios para a disciplina Tópicos Especiais em Inteligência Artificial - UFPI",
             stargazers_count: 0
           },
           %Repo{
             id: 250_401_242,
             name: "be-the-hero_SemanaOmniStack11",
             html_url: "https://github.com/danilo-vieira/be-the-hero_SemanaOmniStack11",
             description: nil,
             stargazers_count: 1
           }
         ]}
      end)

      # Act
      response =
        conn
        |> get(Routes.user_repos_path(conn, :show, username))
        |> json_response(:ok)

      expected_response = %{
        "repos" => [
          %{
            "description" =>
              "Material necessário para realização do processamento de áudios para a disciplina Tópicos Especiais em Inteligência Artificial - UFPI",
            "html_url" => "https://github.com/danilo-vieira/audio_processing",
            "id" => 247_000_001,
            "name" => "audio_processing",
            "stargazers_count" => 0
          },
          %{
            "description" => nil,
            "html_url" => "https://github.com/danilo-vieira/be-the-hero_SemanaOmniStack11",
            "id" => 250_401_242,
            "name" => "be-the-hero_SemanaOmniStack11",
            "stargazers_count" => 1
          }
        ]
      }

      # Assert
      assert response == expected_response
    end

    test "when the user does not exists, returns an error from github", %{conn: conn} do
      # Arrange
      username = "some-user-that-does-not-exists-lol"

      expect(ClientMock, :get_user_repos, fn _username ->
        {:error, %Error{result: "Not Found", status: :bad_request}}
      end)

      # Act
      response =
        conn
        |> get(Routes.user_repos_path(conn, :show, username))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Not Found"}

      # Assert
      assert response == expected_response
    end
  end
end
