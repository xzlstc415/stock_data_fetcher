defmodule StockDataFetcher.Wangyi.ZcfzbReader do
  alias StockDataFetcher.{BalanceSheet, Stock, Repo, IsDate}
  import Ecto.Query

  @root_path "csv/zcfzb"

  def skip_fields(field) do
    %{
      "股权分置流通权(万元)" => true,
      "应付保证金(万元)" => true,
      "内部应付款(万元)" => true,
      "保险合同准备金(万元)" => true,
      "国际票证结算(万元)" => true,
      "国内票证结算(万元)" => true,
      "应收保证金(万元)" => true
    }[field]
  end

  def fields_map(field) do
    %{
      "报告日期" => :report_date,
      "货币资金(万元)" => :cash,
      "结算备付金(万元)" => :deposit_reservation,
      "拆出资金(万元)" => :lendings_to_financial_institutions,
      "交易性金融资产(万元)" => :held_for_trading_financial_assets,
      "衍生金融资产(万元)" => :financial_derivative,
      "应收票据(万元)" => :bills_receivables,
      "应收账款(万元)" => :accounts_receivables,
      "预付款项(万元)" => :accounts_prepayment,
      "应收保费(万元)" => :premiums_receivables,
      "应收分保账款(万元)" => :reinsurance_premium_receivables,
      "应收分保合同准备金(万元)" => :reinsurance_contract_reserve,
      "应收利息(万元)" => :interest_receivables,
      "应收股利(万元)" => :dividend_receivables,
      "其他应收款(万元)" => :other_receivables,
      "应收出口退税(万元)" => :export_tax_rebate_receivables,
      "应收补贴款(万元)" => :allowance_receivables,
      "内部应收款(万元)" => :internal_receivables,
      "买入返售金融资产(万元)" => :buying_back_the_sale_of_financial_assets,
      "存货(万元)" => :inventory,
      "待摊费用(万元)" => :unamortized_expenditures,
      "待处理流动资产损益(万元)" => :pending_current_assets_loss,
      "一年内到期的非流动资产(万元)" => :long_term_assets_due_within_one_year,
      "其他流动资产(万元)" => :other_current_assets,
      "流动资产合计(万元)" => :total_current_assets,
      "发放贷款及垫款(万元)" => :loans_and_advances_to_customer,
      "可供出售金融资产(万元)" => :available_for_sale_financial_assets,
      "持有至到期投资(万元)" => :held_to_maturity_investment,
      "长期应收款(万元)" => :long_term_receivables,
      "长期股权投资(万元)" => :long_term_equity_investment,
      "其他长期投资(万元)" => :other_long_term_investment,
      "投资性房地产(万元)" => :investment_properties,
      "固定资产原值(万元)" => :original_value_of_fixed_assets,
      "累计折旧(万元)" => :accumulated_depreciation,
      "固定资产净值(万元)" => :net_value_of_fixed_assets,
      "固定资产减值准备(万元)" => :fixed_assets_depreciation_reserves,
      "固定资产(万元)" => :fixed_assets,
      "在建工程(万元)" => :construction_in_progress,
      "工程物资(万元)" => :engineer_material,
      "固定资产清理(万元)" => :fixed_assets_in_liquidation,
      "生产性生物资产(万元)" => :capitalized_biological_assets,
      "公益性生物资产(万元)" => :non_profit_living_assets,
      "油气资产(万元)" => :oil_and_gas_assets,
      "无形资产(万元)" => :intangible_assets,
      "开发支出(万元)" => :development_expenditure,
      "商誉(万元)" => :goodwill,
      "长期待摊费用(万元)" => :long_term_deferred_expenses,
      "递延所得税资产(万元)" => :deferred_income_tax_assets,
      "其他非流动资产(万元)" => :other_long_term_assets,
      "非流动资产合计(万元)" => :total_long_term_assets,
      "资产总计(万元)" => :total_assets,
      "短期借款(万元)" => :short_term_borrowing,
      "向中央银行借款(万元)" => :borrowing_from_the_central_bank,
      "吸收存款及同业存放(万元)" => :accept_money_deposits_and_interbank_placement,
      "拆入资金(万元)" => :loans_from_other_banks,
      "交易性金融负债(万元)" => :transaction_financial_liabilities,
      "衍生金融负债(万元)" => :derivative_financial_liabilities,
      "应付票据(万元)" => :bills_payables,
      "应付账款(万元)" => :accounts_payables,
      "预收账款(万元)" => :accounts_received_in_advance,
      "卖出回购金融资产款(万元)" => :financial_assets_solf_for_repruchase,
      "应付手续费及佣金(万元)" => :service_fee_payables,
      "应付职工薪酬(万元)" => :payroll_payables,
      "应交税费(万元)" => :tax_and_dues_payables,
      "应付利息(万元)" => :interest_payables,
      "应付股利(万元)" => :dividend_payables,
      "其他应交款(万元)" => :other_levies_payables,
      "其他应付款(万元)" => :other_payables,
      "预提费用(万元)" => :withholding_expenses,
      "预计流动负债(万元)" => :estimated_current_liabilities,
      "应付分保账款(万元)" => :the_payable_reinsurance,
      "代理买卖证券款(万元)" => :acting_trading_securities,
      "代理承销证券款(万元)" => :acting_underwriting_securities,
      "递延收益(万元)" => :deferred_income,
      "应付短期债券(万元)" => :short_term_debentures_payables,
      "一年内到期的非流动负债(万元)" => :long_term_liabilities_due_within_one_year,
      "其他流动负债(万元)" => :other_current_liabilities,
      "流动负债合计(万元)" => :total_current_liabilities,
      "长期借款(万元)" => :long_term_borrowing,
      "应付债券(万元)" => :bone_payables,
      "长期应付款(万元)" => :long_term_payables,
      "专项应付款(万元)" => :special_payables,
      "预计非流动负债(万元)" => :estimated_long_term_liabilities,
      "长期递延收益(万元)" => :long_term_deferred_income,
      "递延所得税负债(万元)" => :deferred_income_tax_liabilities,
      "其他非流动负债(万元)" => :other_long_term_liabilities,
      "非流动负债合计(万元)" => :total_long_term_liabilities,
      "负债合计(万元)" => :total_liabilities,
      "实收资本(或股本)(万元)" => :actual_receipt_capital,
      "资本公积(万元)" => :additional_paid_in_capital,
      "减:库存股(万元)" => :treasury_stock,
      "专项储备(万元)" => :special_reserves,
      "盈余公积(万元)" => :features_surplus,
      "一般风险准备(万元)" => :general_risk_preparation,
      "未确定的投资损失(万元)" => :pending_investment_lost,
      "未分配利润(万元)" => :undistributed_profits,
      "拟分配现金股利(万元)" => :proposed_distribution_of_cash_dividends,
      "外币报表折算差额(万元)" => :converted_difference_in_foreign_currency_statements_reserves,
      "归属于母公司股东权益合计(万元)" => :parent_company_stockholders_interest,
      "少数股东权益(万元)" => :minority_stockholders_interest,
      "所有者权益(或股东权益)合计(万元)" => :owners_equity,
      "负债和所有者权益(或股东权益)总计(万元)" => :total_liabilities_and_equity
    }[field]
  end

  def insert_balance_sheets do
    {:ok, file_list} = File.ls(@root_path)

    file_list
    |> Enum.sort()
    |> Enum.each(&read_balance_sheet/1)
  end

  def read_balance_sheet(file) do
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

            if skip_fields(field_name) do
              acc
            else
              field_name = fields_map(field_name)
              Map.put(acc, field_name, parse_result(Enum.at(data, index)))
            end

          {:error, _} ->
            acc
        end
      end)
      |> find_or_create_balance_sheet(stock)
    end)
  end

  def find_or_create_balance_sheet(%{nil: ""}, _) do
    IO.inspect("spreedsheet is empty")
  end

  def find_or_create_balance_sheet(balance_sheet, stock) do
    result =
      case Repo.get_by(BalanceSheet, stock_id: stock.id, report_date: balance_sheet.report_date) do
        nil -> %BalanceSheet{}
        exist_record -> exist_record
      end
      |> Repo.preload(:stock)
      |> BalanceSheet.changeset(balance_sheet)
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
          {:error, _} -> String.to_integer(data)
        end
    end
  end

  def fetch_data_from_csv(file) do
    "#{@root_path}/#{file}"
    |> File.stream!()
    |> CSV.decode()
  end
end
