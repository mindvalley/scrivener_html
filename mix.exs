defmodule ScrivenerHtml.Mixfile do
  use Mix.Project

  @version "2.0.0"
  def project do
    [
      app: :scrivener_html,
      version: @version,
      elixir: "~> 1.16.3",
      name: "scrivener_html",
      source_url: "https://github.com/mgwidmann/scrivener_html",
      homepage_url: "https://github.com/mgwidmann/scrivener_html",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: "HTML helpers for Scrivener",
      docs: [
        main: Scrivener.HTML,
        readme: "README.md"
      ],
      package: package(),
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      extra_applications: [:phoenix, :phoenix_html, :scrivener]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:scrivener, "~> 2.7"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_html_helpers, "~> 1.0"},
      {:phoenix, "~> 1.7"},
      {:plug, "~> 1.16"},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.34.1", only: :dev},
      {:earmark, "~> 1.4", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Matt Widmann"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/mgwidmann/scrivener_html"}
    ]
  end

  defp aliases do
    [publish: ["hex.publish", "hex.publish docs", "tag"], tag: &tag_release/1]
  end

  defp tag_release(_) do
    Mix.shell().info("Tagging release as #{@version}")
    System.cmd("git", ["tag", "-a", "v#{@version}", "-m", "v#{@version}"])
    System.cmd("git", ["push", "--tags"])
  end
end
