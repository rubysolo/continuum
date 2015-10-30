defmodule Continuum.Mixfile do
  use Mix.Project

  def project do
    [
      app: :continuum,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      package: package,
      description: "Audit trail for your Ecto models",
      deps: deps,
      docs: [
        main: Continuum,
        readme: "README.md"
      ]
   ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      maintainers: ["Solomon White"],
      licenses: ["MIT"],
      links: %{"github" => "https://github/rubysolo/continuum"}
    ]
  end

  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(:test), do: [:postgrex, :ecto, :logger]
  defp applications(_), do: [:logger]

  defp deps do
    [
      {:ecto,     "~> 1.0"},
      {:postgrex, "~> 0.9.0"},
      {:poison,   "~> 1.5.0"},
    ]
  end
end
