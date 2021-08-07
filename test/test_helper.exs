ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(RepoList.Repo, :manual)

Mox.defmock(RepoList.Github.ClientMock, for: RepoList.Github.Behaviour)
