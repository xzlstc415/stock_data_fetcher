defmodule StockDataFetcher.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do
    field(:name, :string)
    field(:code, :string)
    field(:symbol, :string)
    many_to_many(:sectors, StockDataFetcher.Sector, join_through: "sectors_stocks")
    has_many(:balance_sheets, StockDataFetcher.BalanceSheet)
    has_many(:income_statements, StockDataFetcher.IncomeStatement)
  end

  def changeset(stock, params \\ %{}) do
    stock
    |> cast(params, [:name, :code, :symbol])
    |> validate_required([:code, :symbol])
  end
end
