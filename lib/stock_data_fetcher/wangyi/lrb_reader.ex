defmodule StockDataFetcher.Wangyi.LrbReader do
  alias StockDataFetcher.{IncomeStatement, Stock, Repo, IsDate, Parser}
  import Ecto.Query

  @root_path "csv/lrb"

  def fields_map(field) do
    %{
      "报告日期" => :report_date,
      "营业总收入(万元)" => :total_revenue,
      "营业收入(万元)" => :operating_revenue,
      "利息收入(万元)" => :interest_revenue,
      "已赚保费(万元)" => :premium_income,
      "手续费及佣金收入(万元)" => :service_fee_and_commission_income,
      "房地产销售收入(万元)" => :sale_revenue_of_real_estate,
      "其他业务收入(万元)" => :other_business_revenue,
      "营业总成本(万元)" => :total_cost_of_revenue,
      "营业成本(万元)" => :total_operating_cost,
      "利息支出(万元)" => :total_interest_expenses,
      "手续费及佣金支出(万元)" => :service_fee_and_commission_expenses,
      "房地产销售成本(万元)" => :sales_cost_of_real_estate,
      "研发费用(万元)" => :r_and_d_expenses,
      "退保金(万元)" => :surrender_value,
      "赔付支出净额(万元)" => :compensation_expenses,
      "提取保险合同准备金净额(万元)" => :appropriation_of_deposit_for_duty,
      "保单红利支出(万元)" => :expenditures_dividend_policy,
      "分保费用(万元)" => :amortized_reinsurance_expenditures,
      "其他业务成本(万元)" => :other_operational_costs,
      "营业税金及附加(万元)" => :business_taxes_and_surcharges,
      "销售费用(万元)" => :selling_expenses,
      "管理费用(万元)" => :management_cost,
      "财务费用(万元)" => :financing_expenses,
      "资产减值损失(万元)" => :assets_devaluation,
      "公允价值变动收益(万元)" => :income_from_changes_in_fair_value,
      "投资收益(万元)" => :investment_income,
      "对联营企业和合营企业的投资收益(万元)" => :investment_income_from_joint_ownership_enterprises,
      "汇兑收益(万元)" => :exchange_gains,
      "期货损益(万元)" => :futures_profits,
      "托管收益(万元)" => :trusteeship_profits,
      "补贴收入(万元)" => :subsidize_revenue,
      "其他业务利润(万元)" => :other_business_operations_profits,
      "营业利润(万元)" => :sales_profits,
      "营业外收入(万元)" => :non_business_income,
      "营业外支出(万元)" => :non_business_expenses,
      "非流动资产处置损失(万元)" => :disposal_loss_on_non_current_liability,
      "利润总额(万元)" => :total_profits,
      "所得税费用(万元)" => :income_tax_expenses,
      "未确认投资损失(万元)" => :pending_investment_loss,
      "净利润(万元)" => :net_profits,
      "归属于母公司所有者的净利润(万元)" => :net_profit_attributable_to_owners_of_the_parent_company,
      "被合并方在合并前实现净利润(万元)" => :net_profit_recognized_before_the_merger,
      "少数股东损益(万元)" => :minority_interes_tincome,
      "基本每股收益" => :basic_earning_per_share,
      "稀释每股收益" => :fully_diluted_earnings_per_share
    }[field]
  end

  def insert_income_statements do
    {:ok, file_list} = File.ls(@root_path)

    file_list
    |> Enum.sort()
    |> Enum.each(&read_income_statement/1)
  end

  def read_income_statement(file) do
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
            field_name = fields_map(field_name)
            Map.put(acc, field_name, parse_result(Enum.at(data, index)))

          {:error, _} ->
            acc
        end
      end)
      |> find_or_create_income_statement(stock)
    end)
  end

  def find_or_create_income_statement(%{nil: ""}, _) do
    IO.inspect("spreedsheet is empty")
  end

  def find_or_create_income_statement(income_statement, stock) do
    result =
      case Repo.get_by(IncomeStatement,
             stock_id: stock.id,
             report_date: income_statement.report_date
           ) do
        nil -> %IncomeStatement{}
        exist_record -> exist_record
      end
      |> Repo.preload(:stock)
      |> IncomeStatement.changeset(income_statement)
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
