defmodule StockDataFetcher.Repo.Migrations.CreateStock do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :name, :string, null: false
      add :code, :string, null: false
      add :symbol, :string, null: false
    end
    create index(:stocks, [:code], unique: true)
  end
end
