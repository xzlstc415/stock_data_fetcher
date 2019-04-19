defmodule StockDataFetcher.CashflowStatement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cashflow_statements" do
    field(:report_date, :date)
    field(:cash_received_sales, :integer, default: 0)
    field(:net_increase_customer_bank_deposits, :integer, default: 0)
    field(:borrowings_central_bank, :integer, default: 0)
    field(:net_increase_placements_other_financial_institution, :integer, default: 0)
    field(:premiums_received_original_insurance_contract, :integer, default: 0)
    field(:net_cash_received_reinsurance_business, :integer, default: 0)
    field(:net_increase_deposits_policyholder, :integer, default: 0)
    field(:net_increase_disposal_tradable_financial_assets, :integer, default: 0)
    field(:interest_handling_charges_commission_received, :integer, default: 0)
    field(:net_increase_placements_banks, :integer, default: 0)
    field(:net_increase_repurchase_business_capital, :integer, default: 0)
    field(:tax_rebate_received, :integer, default: 0)
    field(:other_cash_received_operating_activities, :integer, default: 0)
    field(:cash_inflows_operating_activities, :integer, default: 0)
    field(:cash_paid_goods_purchased_service_received, :integer, default: 0)
    field(:net_increase_loans_advances_customers, :integer, default: 0)
    field(:net_increase_deposits_with_central_bank_others, :integer, default: 0)
    field(:original_insurance_contract_claims_paid, :integer, default: 0)
    field(:interest_handling_charges_commissions_paid, :integer, default: 0)
    field(:policyholder_dividend_paid, :integer, default: 0)
    field(:cash_paid_employees, :integer, default: 0)
    field(:cash_paid_tax_surcharges, :integer, default: 0)
    field(:cash_paid_other_operating_activities, :integer, default: 0)
    field(:cash_outflows_operating_activities, :integer, default: 0)
    field(:cash_received_disposal_investments, :integer, default: 0)
    field(:investment_income_received, :integer, default: 0)
    field(:net_cash_disposal_fixed_intangible_long_term_assets, :integer, default: 0)
    field(:net_cash_received_disposal_subsidiaries, :integer, default: 0)
    field(:other_cash_received_investing_activities, :integer, default: 0)
    field(:cash_received_decreasing_pledge_time_deposit, :integer, default: 0)
    field(:cash_inflows_investing_activities, :integer, default: 0)
    field(:cash_paid_fixed_intangible_long_term_assets, :integer, default: 0)
    field(:cash_paid_acquisition_investments, :integer, default: 0)
    field(:net_increase_pledge_loans, :integer, default: 0)
    field(:net_cash_paid_acquisition_subsidiaries, :integer, default: 0)
    field(:cash_paid_other_investing_activities, :integer, default: 0)
    field(:cash_paid_increasing_pledge_time_deposit, :integer, default: 0)
    field(:cash_outflows_investing_activities, :integer, default: 0)
    field(:net_cash_flows_investing_activities, :integer, default: 0)
    field(:cash_received_capital_contributions, :integer, default: 0)
    field(:cash_received_cc_by_minority_shareholders_subsidiaries, :integer, default: 0)
    field(:borrowing_received, :integer, default: 0)
    field(:cash_received_bond_issue, :integer, default: 0)
    field(:other_cash_received_financing_activities, :integer, default: 0)
    field(:cash_inflows_financing_activities, :integer, default: 0)
    field(:cash_repayments_amounts_borrowed, :integer, default: 0)
    field(:cash_paid_dividend_profit_distribution_or_interest_payment, :integer, default: 0)
    field(:cash_dividends_profit_minority_shareholders_subsidiaries, :integer, default: 0)
    field(:cash_paid_other_financing_activities, :integer, default: 0)
    field(:cash_outflows_financing_activities, :integer, default: 0)
    field(:net_cash_flows_financing_activities, :integer, default: 0)
    field(:foreign_exchange_rate_fluctuation_on_cash_equivalents, :integer, default: 0)
    field(:beginning_cash_cash_equivalents, :integer, default: 0)
    field(:ending_cash_cash_equivalents, :integer, default: 0)
    field(:net_profit, :integer, default: 0)
    field(:minority_interest_income, :integer, default: 0)
    field(:pending_investment_loss, :integer, default: 0)
    field(:assets_depreciation_reserves, :integer, default: 0)
    field(:depreciation_fixed_oil_productive_biological_assets, :integer, default: 0)
    field(:amortization_intangible_assets, :integer, default: 0)
    field(:long_term_prepaid_expenses, :integer, default: 0)
    field(:decrease_prepaid_expenses, :integer, default: 0)
    field(:increase_withholding_expenses, :integer, default: 0)
    field(:loss_disposal_fixed_intangible_long_term_assets, :integer, default: 0)
    field(:loss_asset_retirement_by_scrapping, :integer, default: 0)
    field(:loss_changes_fair_value, :integer, default: 0)
    field(:increase_deferred_income, :integer, default: 0)
    field(:estimated_liabilities, :integer, default: 0)
    field(:financial_expenses, :integer, default: 0)
    field(:investment_loss, :integer, default: 0)
    field(:decrease_deferred_income_tax_assets, :integer, default: 0)
    field(:increase_deferred_income_tax_liabilities, :integer, default: 0)
    field(:decrease_inventory, :integer, default: 0)
    field(:decrease_operating_receivables, :integer, default: 0)
    field(:increase_operating_payables, :integer, default: 0)
    field(:decrease_cash_receivable_finished_projects, :integer, default: 0)
    field(:increase_cash_advance_unfinished_projects, :integer, default: 0)
    field(:others, :integer, default: 0)
    field(:net_cash_flows_operating_activities, :integer, default: 0)
    field(:conversion_debt_into_capital, :integer, default: 0)
    field(:convertible_bond_due_withone_year, :integer, default: 0)
    field(:fixed_assets_acquired_under_finance_leases, :integer, default: 0)
    field(:ending_balance_cash, :integer, default: 0)
    field(:beginning_balance_cash, :integer, default: 0)
    field(:ending_balance_cash_cash_equivalents, :integer, default: 0)
    field(:beginning_balance_cash_cash_equivalents, :integer, default: 0)
    field(:net_increase_cash_cash_equivalents, :integer, default: 0)
    belongs_to(:stock, StockDataFetcher.Stock)
  end

  def changeset(stock, params \\ %{}) do
    stock
    |> cast(params, [
      :report_date,
      :cash_received_sales,
      :net_increase_customer_bank_deposits,
      :borrowings_central_bank,
      :net_increase_placements_other_financial_institution,
      :premiums_received_original_insurance_contract,
      :net_cash_received_reinsurance_business,
      :net_increase_deposits_policyholder,
      :net_increase_disposal_tradable_financial_assets,
      :interest_handling_charges_commission_received,
      :net_increase_placements_banks,
      :net_increase_repurchase_business_capital,
      :tax_rebate_received,
      :other_cash_received_operating_activities,
      :cash_inflows_operating_activities,
      :cash_paid_goods_purchased_service_received,
      :net_increase_loans_advances_customers,
      :net_increase_deposits_with_central_bank_others,
      :original_insurance_contract_claims_paid,
      :interest_handling_charges_commissions_paid,
      :policyholder_dividend_paid,
      :cash_paid_employees,
      :cash_paid_tax_surcharges,
      :cash_paid_other_operating_activities,
      :cash_outflows_operating_activities,
      :cash_received_disposal_investments,
      :investment_income_received,
      :net_cash_disposal_fixed_intangible_long_term_assets,
      :net_cash_received_disposal_subsidiaries,
      :other_cash_received_investing_activities,
      :cash_received_decreasing_pledge_time_deposit,
      :cash_inflows_investing_activities,
      :cash_paid_fixed_intangible_long_term_assets,
      :cash_paid_acquisition_investments,
      :net_increase_pledge_loans,
      :net_cash_paid_acquisition_subsidiaries,
      :cash_paid_other_investing_activities,
      :cash_paid_increasing_pledge_time_deposit,
      :cash_outflows_investing_activities,
      :net_cash_flows_investing_activities,
      :cash_received_capital_contributions,
      :cash_received_cc_by_minority_shareholders_subsidiaries,
      :borrowing_received,
      :cash_received_bond_issue,
      :other_cash_received_financing_activities,
      :cash_inflows_financing_activities,
      :cash_repayments_amounts_borrowed,
      :cash_paid_dividend_profit_distribution_or_interest_payment,
      :cash_dividends_profit_minority_shareholders_subsidiaries,
      :cash_paid_other_financing_activities,
      :cash_outflows_financing_activities,
      :net_cash_flows_financing_activities,
      :foreign_exchange_rate_fluctuation_on_cash_equivalents,
      :beginning_cash_cash_equivalents,
      :ending_cash_cash_equivalents,
      :net_profit,
      :minority_interest_income,
      :pending_investment_loss,
      :assets_depreciation_reserves,
      :depreciation_fixed_oil_productive_biological_assets,
      :amortization_intangible_assets,
      :long_term_prepaid_expenses,
      :decrease_prepaid_expenses,
      :increase_withholding_expenses,
      :loss_disposal_fixed_intangible_long_term_assets,
      :loss_asset_retirement_by_scrapping,
      :loss_changes_fair_value,
      :increase_deferred_income,
      :estimated_liabilities,
      :financial_expenses,
      :investment_loss,
      :decrease_deferred_income_tax_assets,
      :increase_deferred_income_tax_liabilities,
      :decrease_inventory,
      :decrease_operating_receivables,
      :increase_operating_payables,
      :decrease_cash_receivable_finished_projects,
      :increase_cash_advance_unfinished_projects,
      :others,
      :net_cash_flows_operating_activities,
      :conversion_debt_into_capital,
      :convertible_bond_due_withone_year,
      :fixed_assets_acquired_under_finance_leases,
      :ending_balance_cash,
      :beginning_balance_cash,
      :ending_balance_cash_cash_equivalents,
      :beginning_balance_cash_cash_equivalents,
      :net_increase_cash_cash_equivalents
    ])
  end
end
