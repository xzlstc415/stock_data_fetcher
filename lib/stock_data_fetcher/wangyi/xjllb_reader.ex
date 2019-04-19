defmodule StockDataFetcher.Wangyi.XjllbReader do
  alias StockDataFetcher.{CashflowStatement, Stock, Repo, IsDate, Parser}
  import Ecto.Query

  @root_path "csv/xjllb"

  def fields_map(field) do
    %{
      "报告日期" => :report_date,
      "销售商品、提供劳务收到的现金(万元)" => :cash_received_sales,
      "客户存款和同业存放款项净增加额(万元)" => :net_increase_customer_bank_deposits,
      "向中央银行借款净增加额(万元" => :borrowings_central_bank,
      "向其他金融机构拆入资金净增加额(万元)" => :net_increase_placements_other_financial_institution,
      "收到原保险合同保费取得的现金(万元)" => :premiums_received_original_insurance_contract,
      "收到再保险业务现金净额(万元)" => :net_cash_received_reinsurance_business,
      "保户储金及投资款净增加额(万元)" => :net_increase_deposits_policyholder,
      "处置交易性金融资产净增加额(万元)" => :net_increase_disposal_tradable_financial_assets,
      "收取利息、手续费及佣金的现金(万元)" => :interest_handling_charges_commission_received,
      "拆入资金净增加额(万元)" => :net_increase_placements_banks,
      "回购业务资金净增加额(万元)" => :net_increase_repurchase_business_capital,
      "收到的税费返还(万元)" => :tax_rebate_received,
      "收到的其他与经营活动有关的现金(万元)" => :other_cash_received_operating_activities,
      "经营活动现金流入小计(万元)" => :cash_inflows_operating_activities,
      "购买商品、接受劳务支付的现金(万元)" => :cash_paid_goods_purchased_service_received,
      "客户贷款及垫款净增加额(万元)" => :net_increase_loans_advances_customers,
      "存放中央银行和同业款项净增加额(万元)" => :net_increase_deposits_with_central_bank_others,
      "支付原保险合同赔付款项的现金(万元)" => :original_insurance_contract_claims_paid,
      "支付利息、手续费及佣金的现金(万元)" => :interest_handling_charges_commissions_paid,
      "支付保单红利的现金(万元)" => :policyholder_dividend_paid,
      "支付给职工以及为职工支付的现金(万元)" => :cash_paid_employees,
      "支付的各项税费(万元)" => :cash_paid_tax_surcharges,
      "支付的其他与经营活动有关的现金(万元)" => :cash_paid_other_operating_activities,
      "经营活动现金流出小计(万元)" => :cash_outflows_operating_activities,
      "经营活动产生的现金流量净额(万元)" => :net_cash_flows_operating_activities,
      "收回投资所收到的现金(万元)" => :cash_received_disposal_investments,
      "取得投资收益所收到的现金(万元)" => :investment_income_received,
      "处置固定资产、无形资产和其他长期资产所收回的现金净额(万元)" => :net_cash_disposal_fixed_intangible_long_term_assets,
      "处置子公司及其他营业单位收到的现金净额(万元)" => :net_cash_received_disposal_subsidiaries,
      "收到的其他与投资活动有关的现金(万元)" => :other_cash_received_investing_activities,
      "减少质押和定期存款所收到的现金(万元)" => :cash_received_decreasing_pledge_time_deposit,
      "投资活动现金流入小计(万元)" => :cash_inflows_investing_activities,
      "购建固定资产、无形资产和其他长期资产所支付的现金(万元)" => :cash_paid_fixed_intangible_long_term_assets,
      "投资所支付的现金(万元)" => :cash_paid_acquisition_investments,
      "质押贷款净增加额(万元)" => :net_increase_pledge_loans,
      "取得子公司及其他营业单位支付的现金净额(万元)" => :net_cash_paid_acquisition_subsidiaries,
      "支付的其他与投资活动有关的现金(万元)" => :cash_paid_other_investing_activities,
      "增加质押和定期存款所支付的现金(万元)" => :cash_paid_increasing_pledge_time_deposit,
      "投资活动现金流出小计(万元)" => :cash_outflows_investing_activities,
      "投资活动产生的现金流量净额(万元)" => :net_cash_flows_investing_activities,
      "吸收投资收到的现金(万元)" => :cash_received_capital_contributions,
      "其中：子公司吸收少数股东投资收到的现金(万元)" => :cash_received_cc_by_minority_shareholders_subsidiaries,
      "取得借款收到的现金(万元)" => :borrowing_received,
      "发行债券收到的现金(万元)" => :cash_received_bond_issue,
      "收到其他与筹资活动有关的现金(万元)" => :other_cash_received_financing_activities,
      "筹资活动现金流入小计(万元)" => :cash_inflows_financing_activities,
      "偿还债务支付的现金(万元)" => :cash_repayments_amounts_borrowed,
      "分配股利、利润或偿付利息所支付的现金(万元)" => :cash_paid_dividend_profit_distribution_or_interest_payment,
      "其中：子公司支付给少数股东的股利、利润(万元)" => :cash_dividends_profit_minority_shareholders_subsidiaries,
      "支付其他与筹资活动有关的现金(万元)" => :cash_paid_other_financing_activities,
      "筹资活动现金流出小计(万元)" => :cash_outflows_financing_activities,
      "筹资活动产生的现金流量净额(万元)" => :net_cash_flows_financing_activities,
      "汇率变动对现金及现金等价物的影响(万元)" => :foreign_exchange_rate_fluctuation_on_cash_equivalents,
      "现金及现金等价物净增加额(万元)" => :net_increase_cash_cash_equivalents,
      "加:期初现金及现金等价物余额(万元)" => :beginning_cash_cash_equivalents,
      "期末现金及现金等价物余额(万元)" => :ending_cash_cash_equivalents,
      "净利润(万元)" => :net_profit,
      "少数股东损益(万元)" => :minority_interest_income,
      "未确认的投资损失(万元)" => :pending_investment_loss,
      "资产减值准备(万元)" => :assets_depreciation_reserves,
      "固定资产折旧、油气资产折耗、生产性物资折旧(万元)" => :depreciation_fixed_oil_productive_biological_assets,
      "无形资产摊销(万元)" => :amortization_intangible_assets,
      "长期待摊费用摊销(万元)" => :long_term_prepaid_expenses,
      "待摊费用的减少(万元)" => :decrease_prepaid_expenses,
      "预提费用的增加(万元)" => :increase_withholding_expenses,
      "处置固定资产、无形资产和其他长期资产的损失(万元)" => :loss_disposal_fixed_intangible_long_term_assets,
      "固定资产报废损失(万元)" => :loss_asset_retirement_by_scrapping,
      "公允价值变动损失(万元)" => :loss_changes_fair_value,
      "递延收益增加(减：减少)(万元)" => :increase_deferred_income,
      "预计负债(万元)" => :estimated_liabilities,
      "财务费用(万元)" => :financial_expenses,
      "投资损失(万元)" => :investment_loss,
      "递延所得税资产减少(万元)" => :decrease_deferred_income_tax_assets,
      "递延所得税负债增加(万元)" => :increase_deferred_income_tax_liabilities,
      "存货的减少(万元)" => :decrease_inventory,
      "经营性应收项目的减少(万元)" => :decrease_operating_receivables,
      "经营性应付项目的增加(万元)" => :increase_operating_payables,
      "已完工尚未结算款的减少(减:增加)(万元)" => :decrease_cash_receivable_finished_projects,
      "已结算尚未完工款的增加(减:减少)(万元)" => :increase_cash_advance_unfinished_projects,
      "其他(万元)" => :others,
      "经营活动产生现金流量净额(万元)" => :net_cash_flows_operating_activities,
      "债务转为资本(万元)" => :conversion_debt_into_capital,
      "一年内到期的可转换公司债券(万元)" => :convertible_bond_due_withone_year,
      "融资租入固定资产(万元)" => :fixed_assets_acquired_under_finance_leases,
      "现金的期末余额(万元)" => :ending_balance_cash,
      "现金的期初余额(万元)" => :beginning_balance_cash,
      "现金等价物的期末余额(万元)" => :ending_balance_cash_cash_equivalents,
      "现金等价物的期初余额(万元)" => :beginning_balance_cash_cash_equivalents,
      "现金及现金等价物的净增加额(万元)" => :net_increase_cash_cash_equivalents
    }[field]
  end

  def insert_cashflow_statements do
    {:ok, file_list} = File.ls(@root_path)

    file_list
    |> Enum.sort()
    |> Enum.each(&read_cashflow_statement/1)
  end

  def read_cashflow_statement(file) do
    file
    |> find_stock
    |> process_csv_file(file)
  end

  def find_stock(file) do
    symbol = String.replace(file, ".csv", "")

    Stock
    |> join(:inner, [s], sector in assoc(s, :sectors))
    |> where([s], s.symbol == ^symbol)
    |> group_by([s], s.symbol)
    |> Repo.all()
  end

  def process_csv_file([], file) do
    IO.inspect("stock that match #{file} is not found.")
  end

  def process_csv_file([stock], file) do
    result = fetch_data_from_csv(file)
    [{:ok, dates}] = Enum.take(result, 1)

    i =
      dates
      |> Enum.filter(&IsDate.is_date?(&1))
      |> length

    Enum.each(0..(i - 1), fn index ->
      Enum.reduce(result, %{}, fn row, acc ->
        case row do
          {:ok, data} ->
            [field_name | data] = data
            field_name = fields_map(String.trim(field_name))
            Map.put(acc, field_name, parse_result(Enum.at(data, index)))

          {:error, _} ->
            acc
        end
      end)
      |> find_or_create_cashflow_statement(stock)
    end)
  end

  def find_or_create_cashflow_statement(%{nil: ""}, stock) do
    IO.inspect("#{stock.symbol} spreedsheet is empty")
  end

  def find_or_create_cashflow_statement(cashflow_statement, stock) do
    result =
      case Repo.get_by(CashflowStatement,
             stock_id: stock.id,
             report_date: cashflow_statement.report_date
           ) do
        nil -> %CashflowStatement{}
        exist_record -> exist_record
      end
      |> Repo.preload(:stock)
      |> CashflowStatement.changeset(cashflow_statement)
      |> Ecto.Changeset.put_assoc(:stock, stock)
      |> Repo.insert_or_update()

    case result do
      {:ok, model} -> model
      {:error, changeset} -> IO.puts(changeset.errors)
    end
  end

  def parse_result(data) do
    case data do
      "--" ->
        ""

      " --" ->
        ""

      nil ->
        ""

      data ->
        case Date.from_iso8601(data) do
          {:ok, date} -> date
          {:error, _} -> Parser.parse_number(data)
        end
    end
  end

  def fetch_data_from_csv(file) do
    "#{@root_path}/#{file}"
    |> File.stream!()
    |> CSV.decode()
  end
end
