defmodule RepoList.Error do
  @keys [:message, :status]
  @enforce_keys @keys
  defstruct @keys

  def build(message, status) do
    %__MODULE__{
      message: message,
      status: status
    }
  end
end
