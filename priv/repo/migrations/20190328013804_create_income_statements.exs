defmodule StockDataFetcher.Repo.Migrations.CreateIncomeStatements do
  use Ecto.Migration

  def up do
    create table(:income_statements) do
      add(:stock_id, references(:stocks))
      add(:report_date, :date)
      add(:total_revenue, :bigint, default: 0)
      add(:operating_revenue, :bigint, default: 0)
      add(:interest_revenue, :bigint, default: 0)
      add(:premium_income, :integer, default: 0)
      add(:service_fee_and_commission_income, :integer, default: 0)
      add(:sale_revenue_of_real_estate, :integer, default: 0)
      add(:other_business_revenue, :integer, default: 0)
      add(:total_cost_of_revenue, :bigint, default: 0)
      add(:total_operating_cost, :bigint, default: 0)
      add(:total_interest_expenses, :bigint, default: 0)
      add(:service_fee_and_commission_expenses, :integer, default: 0)
      add(:sales_cost_of_real_estate, :integer, default: 0)
      add(:r_and_d_expenses, :integer, default: 0)
      add(:surrender_value, :integer, default: 0)
      add(:compensation_expenses, :integer, default: 0)
      add(:appropriation_of_deposit_for_duty, :integer, default: 0)
      add(:expenditures_dividend_policy, :integer, default: 0)
      add(:amortized_reinsurance_expenditures, :integer, default: 0)
      add(:other_operational_costs, :integer, default: 0)
      add(:business_taxes_and_surcharges, :integer, default: 0)
      add(:selling_expenses, :integer, default: 0)
      add(:management_cost, :integer, default: 0)
      add(:financing_expenses, :integer, default: 0)
      add(:assets_devaluation, :integer, default: 0)
      add(:income_from_changes_in_fair_value, :integer, default: 0)
      add(:investment_income, :integer, default: 0)
      add(:investment_income_from_joint_ownership_enterprises, :integer, default: 0)
      add(:exchange_gains, :integer, default: 0)
      add(:futures_profits, :integer, default: 0)
      add(:trusteeship_profits, :integer, default: 0)
      add(:subsidize_revenue, :integer, default: 0)
      add(:other_business_operations_profits, :integer, default: 0)
      add(:sales_profits, :bigint, default: 0)
      add(:non_business_income, :integer, default: 0)
      add(:non_business_expenses, :integer, default: 0)
      add(:disposal_loss_on_non_current_liability, :integer, default: 0)
      add(:total_profits, :bigint, default: 0)
      add(:income_tax_expenses, :integer, default: 0)
      add(:pending_investment_loss, :integer, default: 0)
      add(:net_profits, :bigint, default: 0)
      add(:net_profit_attributable_to_owners_of_the_parent_company, :integer, default: 0)
      add(:net_profit_recognized_before_the_merger, :integer, default: 0)
      add(:minority_interes_tincome, :integer, default: 0)
      add(:basic_earning_per_share, :float)
      add(:fully_diluted_earnings_per_share, :float)
    end

    create(index(:income_statements, [:report_date]))
    create(index(:income_statements, [:stock_id, :report_date], unique: true))
  end

  def down do
    drop(table(:income_statements))
  end
end
