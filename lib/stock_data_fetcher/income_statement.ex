defmodule StockDataFetcher.IncomeStatement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "income_statements" do
    field(:report_date, :date)
    field(:total_revenue, :integer, default: 0)
    field(:operating_revenue, :integer, default: 0)
    field(:interest_revenue, :integer, default: 0)
    field(:premium_income, :integer, default: 0)
    field(:service_fee_and_commission_income, :integer, default: 0)
    field(:sale_revenue_of_real_estate, :integer, default: 0)
    field(:other_business_revenue, :integer, default: 0)
    field(:total_cost_of_revenue, :integer, default: 0)
    field(:total_operating_cost, :integer, default: 0)
    field(:total_interest_expenses, :integer, default: 0)
    field(:service_fee_and_commission_expenses, :integer, default: 0)
    field(:sales_cost_of_real_estate, :integer, default: 0)
    field(:r_and_d_expenses, :integer, default: 0)
    field(:surrender_value, :integer, default: 0)
    field(:compensation_expenses, :integer, default: 0)
    field(:appropriation_of_deposit_for_duty, :integer, default: 0)
    field(:expenditures_dividend_policy, :integer, default: 0)
    field(:amortized_reinsurance_expenditures, :integer, default: 0)
    field(:other_operational_costs, :integer, default: 0)
    field(:business_taxes_and_surcharges, :integer, default: 0)
    field(:selling_expenses, :integer, default: 0)
    field(:management_cost, :integer, default: 0)
    field(:financing_expenses, :integer, default: 0)
    field(:assets_devaluation, :integer, default: 0)
    field(:income_from_changes_in_fair_value, :integer, default: 0)
    field(:investment_income, :integer, default: 0)
    field(:investment_income_from_joint_ownership_enterprises, :integer, default: 0)
    field(:exchange_gains, :integer, default: 0)
    field(:futures_profits, :integer, default: 0)
    field(:trusteeship_profits, :integer, default: 0)
    field(:subsidize_revenue, :integer, default: 0)
    field(:other_business_operations_profits, :integer, default: 0)
    field(:sales_profits, :integer, default: 0)
    field(:non_business_income, :integer, default: 0)
    field(:non_business_expenses, :integer, default: 0)
    field(:disposal_loss_on_non_current_liability, :integer, default: 0)
    field(:total_profits, :integer, default: 0)
    field(:income_tax_expenses, :integer, default: 0)
    field(:pending_investment_loss, :integer, default: 0)
    field(:net_profits, :integer, default: 0)
    field(:net_profit_attributable_to_owners_of_the_parent_company, :integer, default: 0)
    field(:net_profit_recognized_before_the_merger, :integer, default: 0)
    field(:minority_interes_tincome, :integer, default: 0)
    field(:basic_earning_per_share, :float)
    field(:fully_diluted_earnings_per_share, :float)
    belongs_to(:stock, StockDataFetcher.Stock)
  end

  def changeset(stock, params \\ %{}) do
    stock
    |> cast(params, [
      :report_date,
      :total_revenue,
      :operating_revenue,
      :interest_revenue,
      :premium_income,
      :service_fee_and_commission_income,
      :sale_revenue_of_real_estate,
      :other_business_revenue,
      :total_cost_of_revenue,
      :total_operating_cost,
      :total_interest_expenses,
      :service_fee_and_commission_expenses,
      :sales_cost_of_real_estate,
      :r_and_d_expenses,
      :surrender_value,
      :compensation_expenses,
      :appropriation_of_deposit_for_duty,
      :expenditures_dividend_policy,
      :amortized_reinsurance_expenditures,
      :other_operational_costs,
      :business_taxes_and_surcharges,
      :selling_expenses,
      :management_cost,
      :financing_expenses,
      :assets_devaluation,
      :income_from_changes_in_fair_value,
      :investment_income,
      :investment_income_from_joint_ownership_enterprises,
      :exchange_gains,
      :futures_profits,
      :trusteeship_profits,
      :subsidize_revenue,
      :other_business_operations_profits,
      :sales_profits,
      :non_business_income,
      :non_business_expenses,
      :disposal_loss_on_non_current_liability,
      :total_profits,
      :income_tax_expenses,
      :pending_investment_loss,
      :net_profits,
      :net_profit_attributable_to_owners_of_the_parent_company,
      :net_profit_recognized_before_the_merger,
      :minority_interes_tincome,
      :basic_earning_per_share,
      :fully_diluted_earnings_per_share
    ])
  end
end
