defmodule StockDataFetcher.Repo.Migrations.CreateSectors do
  use Ecto.Migration

  def change do
    create table(:sectors) do
      add :name, :string, null: false
      add :plate_id, :string, null: false
      add :type, :string, null: false
    end
    create index(:sectors, [:plate_id], unique: true)
  end
end
