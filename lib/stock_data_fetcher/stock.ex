defmodule StockDataFetcher.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do
    field :name, :string
    field :code, :string
    field :symbol, :string
  end

  def changeset(stock, params \\ %{}) do
    stock
    |> cast(params, [:name, :code, :symbol])
    |> validate_required([:code, :symbol])
  end
end
