defmodule StockDataFetcher.MixProject do
  use Mix.Project

  def project do
    [
      app: :stock_data_fetcher,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {StockDataFetcher.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:mariaex, ">= 0.0.0"},
      {:jason, "~> 1.1"},
      {:csv, "~> 2.3"}
    ]
  end
end
