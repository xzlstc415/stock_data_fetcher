defmodule StockDataFetcher.Repo.Migrations.CreateSectorsStocks do
  use Ecto.Migration

  def change do
    create table(:sectors_stocks) do
      add :stock_id, references(:stocks)
      add :sector_id, references(:sectors)
    end

    create unique_index(:sectors_stocks, [:stock_id, :sector_id])
  end
end
