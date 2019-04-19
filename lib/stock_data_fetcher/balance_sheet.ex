defmodule StockDataFetcher.BalanceSheet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balance_sheets" do
    field(:report_date, :date)
    field(:cash, :integer, default: 0)
    field(:deposit_reservation, :integer, default: 0)
    field(:lendings_to_financial_institutions, :integer, default: 0)
    field(:held_for_trading_financial_assets, :integer, default: 0)
    field(:financial_derivative, :integer, default: 0)
    field(:bills_receivables, :integer, default: 0)
    field(:accounts_receivables, :integer, default: 0)
    field(:accounts_prepayment, :integer, default: 0)
    field(:premiums_receivables, :integer, default: 0)
    field(:reinsurance_premium_receivables, :integer, default: 0)
    field(:reinsurance_contract_reserve, :integer, default: 0)
    field(:interest_receivables, :integer, default: 0)
    field(:dividend_receivables, :integer, default: 0)
    field(:other_receivables, :integer, default: 0)
    field(:export_tax_rebate_receivables, :integer, default: 0)
    field(:allowance_receivables, :integer, default: 0)
    field(:internal_receivables, :integer, default: 0)
    field(:buying_back_the_sale_of_financial_assets, :integer, default: 0)
    field(:inventory, :integer, default: 0)
    field(:unamortized_expenditures, :integer, default: 0)
    field(:pending_current_assets_loss, :integer, default: 0)
    field(:other_current_assets, :integer, default: 0)
    field(:total_current_assets, :integer, default: 0)
    field(:loans_and_advances_to_customer, :integer, default: 0)
    field(:available_for_sale_financial_assets, :integer, default: 0)
    field(:held_to_maturity_investment, :integer, default: 0)
    field(:long_term_receivables, :integer, default: 0)
    field(:long_term_equity_investment, :integer, default: 0)
    field(:other_long_term_investment, :integer, default: 0)
    field(:investment_properties, :integer, default: 0)
    field(:original_value_of_fixed_assets, :integer, default: 0)
    field(:accumulated_depreciation, :integer, default: 0)
    field(:net_value_of_fixed_assets, :integer, default: 0)
    field(:fixed_assets_depreciation_reserves, :integer, default: 0)
    field(:fixed_assets, :integer, default: 0)
    field(:construction_in_progress, :integer, default: 0)
    field(:engineer_material, :integer, default: 0)
    field(:fixed_assets_in_liquidation, :integer, default: 0)
    field(:capitalized_biological_assets, :integer, default: 0)
    field(:non_profit_living_assets, :integer, default: 0)
    field(:oil_and_gas_assets, :integer, default: 0)
    field(:intangible_assets, :integer, default: 0)
    field(:development_expenditure, :integer, default: 0)
    field(:goodwill, :integer, default: 0)
    field(:long_term_deferred_expenses, :integer, default: 0)
    field(:deferred_income_tax_assets, :integer, default: 0)
    field(:other_long_term_assets, :integer, default: 0)
    field(:total_long_term_assets, :integer, default: 0)
    field(:total_assets, :integer, default: 0)
    field(:short_term_borrowing, :integer, default: 0)
    field(:borrowing_from_the_central_bank, :integer, default: 0)
    field(:accept_money_deposits_and_interbank_placement, :integer, default: 0)
    field(:loans_from_other_banks, :integer, default: 0)
    field(:transaction_financial_liabilities, :integer, default: 0)
    field(:derivative_financial_liabilities, :integer, default: 0)
    field(:bills_payables, :integer, default: 0)
    field(:accounts_payables, :integer, default: 0)
    field(:accounts_received_in_advance, :integer, default: 0)
    field(:financial_assets_solf_for_repruchase, :integer, default: 0)
    field(:service_fee_payables, :integer, default: 0)
    field(:payroll_payables, :integer, default: 0)
    field(:tax_and_dues_payables, :integer, default: 0)
    field(:interest_payables, :integer, default: 0)
    field(:dividend_payables, :integer, default: 0)
    field(:other_levies_payables, :integer, default: 0)
    field(:other_payables, :integer, default: 0)
    field(:withholding_expenses, :integer, default: 0)
    field(:estimated_current_liabilities, :integer, default: 0)
    field(:the_payable_reinsurance, :integer, default: 0)
    field(:acting_trading_securities, :integer, default: 0)
    field(:acting_underwriting_securities, :integer, default: 0)
    field(:deferred_income, :integer, default: 0)
    field(:short_term_debentures_payables, :integer, default: 0)
    field(:long_term_assets_due_within_one_year, :integer, default: 0)
    field(:other_current_liabilities, :integer, default: 0)
    field(:total_current_liabilities, :integer, default: 0)
    field(:long_term_borrowing, :integer, default: 0)
    field(:bone_payables, :integer, default: 0)
    field(:long_term_payables, :integer, default: 0)
    field(:special_payables, :integer, default: 0)
    field(:estimated_long_term_liabilities, :integer, default: 0)
    field(:long_term_deferred_income, :integer, default: 0)
    field(:deferred_income_tax_liabilities, :integer, default: 0)
    field(:other_long_term_liabilities, :integer, default: 0)
    field(:total_long_term_liabilities, :integer, default: 0)
    field(:total_liabilities, :integer, default: 0)
    field(:actual_receipt_capital, :integer, default: 0)
    field(:additional_paid_in_capital, :integer, default: 0)
    field(:treasury_stock, :integer, default: 0)
    field(:special_reserves, :integer, default: 0)
    field(:features_surplus, :integer, default: 0)
    field(:general_risk_preparation, :integer, default: 0)
    field(:pending_investment_lost, :integer, default: 0)
    field(:undistributed_profits, :integer, default: 0)
    field(:proposed_distribution_of_cash_dividends, :integer, default: 0)
    field(:converted_difference_in_foreign_currency_statements_reserves, :integer, default: 0)
    field(:parent_company_stockholders_interest, :integer, default: 0)
    field(:minority_stockholders_interest, :integer, default: 0)
    field(:owners_equity, :integer, default: 0)
    field(:total_liabilities_and_equity, :integer, default: 0)
    belongs_to(:stock, StockDataFetcher.Stock)
  end

  def changeset(stock, params \\ %{}) do
    stock
    |> cast(params, [
      :report_date,
      :cash,
      :deposit_reservation,
      :lendings_to_financial_institutions,
      :held_for_trading_financial_assets,
      :financial_derivative,
      :bills_receivables,
      :accounts_receivables,
      :accounts_prepayment,
      :premiums_receivables,
      :reinsurance_premium_receivables,
      :reinsurance_contract_reserve,
      :interest_receivables,
      :dividend_receivables,
      :other_receivables,
      :export_tax_rebate_receivables,
      :allowance_receivables,
      :internal_receivables,
      :buying_back_the_sale_of_financial_assets,
      :inventory,
      :unamortized_expenditures,
      :pending_current_assets_loss,
      :other_current_assets,
      :total_current_assets,
      :loans_and_advances_to_customer,
      :available_for_sale_financial_assets,
      :held_to_maturity_investment,
      :long_term_receivables,
      :long_term_equity_investment,
      :other_long_term_investment,
      :investment_properties,
      :original_value_of_fixed_assets,
      :accumulated_depreciation,
      :net_value_of_fixed_assets,
      :fixed_assets_depreciation_reserves,
      :fixed_assets,
      :construction_in_progress,
      :engineer_material,
      :fixed_assets_in_liquidation,
      :capitalized_biological_assets,
      :non_profit_living_assets,
      :oil_and_gas_assets,
      :intangible_assets,
      :development_expenditure,
      :goodwill,
      :long_term_deferred_expenses,
      :deferred_income_tax_assets,
      :other_long_term_assets,
      :total_long_term_assets,
      :total_assets,
      :short_term_borrowing,
      :borrowing_from_the_central_bank,
      :accept_money_deposits_and_interbank_placement,
      :loans_from_other_banks,
      :transaction_financial_liabilities,
      :derivative_financial_liabilities,
      :bills_payables,
      :accounts_payables,
      :accounts_received_in_advance,
      :financial_assets_solf_for_repruchase,
      :service_fee_payables,
      :payroll_payables,
      :tax_and_dues_payables,
      :interest_payables,
      :dividend_payables,
      :other_levies_payables,
      :other_payables,
      :withholding_expenses,
      :estimated_current_liabilities,
      :the_payable_reinsurance,
      :acting_trading_securities,
      :acting_underwriting_securities,
      :deferred_income,
      :short_term_debentures_payables,
      :long_term_assets_due_within_one_year,
      :other_current_liabilities,
      :total_current_liabilities,
      :long_term_borrowing,
      :bone_payables,
      :long_term_payables,
      :special_payables,
      :estimated_long_term_liabilities,
      :long_term_deferred_income,
      :deferred_income_tax_liabilities,
      :other_long_term_liabilities,
      :total_long_term_liabilities,
      :total_liabilities,
      :actual_receipt_capital,
      :additional_paid_in_capital,
      :treasury_stock,
      :special_reserves,
      :features_surplus,
      :general_risk_preparation,
      :pending_investment_lost,
      :undistributed_profits,
      :proposed_distribution_of_cash_dividends,
      :converted_difference_in_foreign_currency_statements_reserves,
      :parent_company_stockholders_interest,
      :minority_stockholders_interest,
      :owners_equity,
      :total_liabilities_and_equity
    ])
  end
end
