defmodule Continuum.TestCase do
  use ExUnit.CaseTemplate

  using(_opts) do
    quote do
      #use ExSpec, unquote(opts)
      import Ecto.Query
    end
  end

  setup do
    Ecto.Adapters.SQL.begin_test_transaction(Continuum.Repo)

    ExUnit.Callbacks.on_exit(fn ->
      Ecto.Adapters.SQL.rollback_test_transaction(Continuum.Repo)
    end)
  end
end

Continuum.Repo.start_link
ExUnit.start()
