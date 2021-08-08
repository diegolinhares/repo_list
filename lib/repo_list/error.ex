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

  def build_unauthorized, do: build("Please verify your credentials", :unauthorized)

  def invalid_or_missing_params, do: build("Invalid or missing params", :bad_request)
end
