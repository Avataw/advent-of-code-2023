defmodule AdventOfCode2023.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_of_code_2023,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:memoize, "~> 1.4"},
      {:prioqueue, "~> 0.2.0"},
      {:mix_test_watch, "~> 1.1", only: :dev}
    ]
  end
end
