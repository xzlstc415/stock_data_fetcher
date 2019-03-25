defmodule StockDataFetcher.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do
    field(:name, :string)
    field(:code, :string)
    field(:symbol, :string)
    many_to_many(:sectors, StockDataFetcher.Sector, join_through: "sectors_stocks")
  end

  def changeset(stock, params \\ %{}) do
    stock
    |> cast(params, [:name, :code, :symbol])
    |> validate_required([:code, :symbol])
  end
end
