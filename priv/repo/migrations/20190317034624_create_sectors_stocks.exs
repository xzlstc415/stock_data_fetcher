defmodule StockDataFetcher.Repo.Migrations.CreateSectorsStocks do
  use Ecto.Migration

  def up do
    create table(:sectors_stocks) do
      add :stock_id, references(:stocks)
      add :sector_id, references(:sectors)
    end

    create unique_index(:sectors_stocks, [:stock_id, :sector_id])
  end

  def down do
    drop table(:sectors_stocks)
  end
end
