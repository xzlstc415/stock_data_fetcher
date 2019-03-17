defmodule StockDataFetcher.Repo do
  use Ecto.Repo,
    otp_app: :stock_data_fetcher,
    adapter: Ecto.Adapters.MySQL
end
