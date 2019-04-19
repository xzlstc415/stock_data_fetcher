defmodule StockDataFetcher.Repo.Migrations.ChangeSomeColToBigintInBalanceSheets do
  use Ecto.Migration

  def up do
    alter table(:balance_sheets) do
      modify(:total_assets, :bigint)
      modify(:total_liabilities_and_equity, :bigint)
      modify(:accept_money_deposits_and_interbank_placement, :bigint)
      modify(:total_liabilities, :bigint)
    end
  end

  def down do
  end
end
