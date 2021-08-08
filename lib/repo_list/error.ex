defmodule RepoList.Error do
  @keys [:result, :status]
  @enforce_keys @keys
  defstruct @keys

  def build(result, status) do
    %__MODULE__{
      result: result,
      status: status
    }
  end
end
