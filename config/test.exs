use Mix.Config

config :continuum, Continuum.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool: Ecto.Adapters.SQL.Sandbox,
  database: "continuum_test",
  username: System.get_env("CONTINUUM_DB_USER") || System.get_env("USER")

config :logger, :console, level: :error
