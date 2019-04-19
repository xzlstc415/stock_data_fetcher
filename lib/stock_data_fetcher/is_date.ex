defmodule StockDataFetcher.IsDate do
  def is_date?(date) do
    case Date.from_iso8601(date) do
      {:ok, _} -> true
      _ -> false
    end
  end
end
