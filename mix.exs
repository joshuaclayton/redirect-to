defmodule RedirectTo.Mixfile do
  use Mix.Project

  def project do
    [app: :redirect_to,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.

  def application do
    [mod: {RedirectTo, []},
      applications: app_list(Mix.env) ]
  end

  def app_list do
    [:phoenix, :phoenix_html, :cowboy, :logger, :phoenix_ecto, :postgrex, :tzdata, :ua_inspector, :geolix]
  end

  def app_list(:test), do: [:hound | app_list]
  def app_list(_),     do: app_list

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.0.3"},
      {:phoenix_ecto, "~> 1.1"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.1"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:cowboy, "~> 1.0"},
      {:linguist, "~> 0.1.5"},
      {:hound, "~> 0.7", only: :test},
      {:timex, "~> 0.19.2"},
      {:ua_inspector, github: "joshuaclayton/ua_inspector", branch: "update-module-name"},
      {:ex_machina, "~> 0.5"},
      {:geolix, "~> 0.9"},
      {:yamerl, github: "yakaz/yamerl"}
    ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "dev.prime": ["run priv/repo/prime.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"]]
  end
end
