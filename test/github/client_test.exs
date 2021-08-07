defmodule RepoList.Github.ClientTest do
  use ExUnit.Case, async: true

  alias RepoList.Github.Client

  alias Plug.Conn

  describe "get_user_repos/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when the user exists and has repos, it returns them", %{bypass: bypass} do
      # Arrange
      username = "danilo-vieira"

      url = endpoint_url(bypass.port)

      body = ~s(
        [{
          "id":247000001,
          "name":"audio_processing",
          "html_url":"https://github.com/danilo-vieira/audio_processing",
          "description":"Material necessário para realização do processamento de áudios para a disciplina Tópicos Especiais em Inteligência Artificial - UFPI",
          "stargazers_count":0
        }]
      )

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(200, body)
      end)

      # Act
      response = Client.get_user_repos(url, username)

      expected_response =
        {:ok,
         [
           %RepoList.Github.Repo{
             description:
               "Material necessário para realização do processamento de áudios para a disciplina Tópicos Especiais em Inteligência Artificial - UFPI",
             html_url: "https://github.com/danilo-vieira/audio_processing",
             id: 247_000_001,
             name: "audio_processing",
             stargazers_count: 0
           }
         ]}

      # Assert
      assert response == expected_response
    end

    test "when the user does not exists, it returns an error", %{bypass: bypass} do
      # Arrange
      username = "some-user-that-does-not-exists-lol"

      url = endpoint_url(bypass.port)

      body = ~s(
        { "message": "Not Found" }
      )

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Conn.put_resp_header("content-type", "application/json")
        |> Conn.resp(404, body)
      end)

      # Act
      response = Client.get_user_repos(url, username)

      expected_response =
        {:error, %RepoList.Github.Error{message: "Not Found", status: :bad_request}}

      # Assert
      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
