defmodule StockDataFetcher.Cwsj do
  alias StockDataFetcher.{Repo, Stock}
  import Ecto.Query

  @root_dir File.cwd!()
  @wangyi_lrb_url "http://quotes.money.163.com/service/lrb_"
  @wangyi_zcfzb_url "http://quotes.money.163.com/service/zcfzb_"
  @wangyi_xjllb_url "http://quotes.money.163.com/service/xjllb_"

  def fetch_all do
    Stock
    |> select([s], map(s, [:code, :symbol]))
    |> join(:inner, [s], sector in assoc(s, :sectors))
    |> where([s], s.id > 1295)
    |> group_by([s], s.symbol)
    |> order_by(:symbol)
    |> Repo.all()
    |> Enum.each(fn stock -> fetch(stock) end)
  end

  def fetch(stock) do
    :timer.sleep(3000)
    download(stock.symbol)
  end

  def download(symbol) do
    # :httpc.request(["#{@wangyi_zcfzb_url}#{symbol}.html"])
    # |> save_zcfzb(symbol)

    :httpc.request(["#{@wangyi_lrb_url}#{symbol}.html"])
    |> save_lrb(symbol)

    :httpc.request(["#{@wangyi_xjllb_url}#{symbol}.html"])
    |> save_xjllb(symbol)
  end

  def save_zcfzb({:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}}, symbol) do
    File.write!("#{@root_dir}/csv/zcfzb/#{symbol}.csv", body)
  end

  def save_zcfzb({:ok, {{'HTTP/1.1', 404, 'Not Found'}, _, _}}, symbol) do
    IO.inspect("downloading #{symbol} not found")
  end

  def save_zcfzb({:error, :socket_closed_remotely}, symbol) do
    IO.inspect("downloading #{symbol} went wrong")
  end

  def save_xjllb({:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}}, symbol) do
    File.write!("#{@root_dir}/csv/xjllb/#{symbol}.csv", body)
  end

  def save_xjllb({:ok, {{'HTTP/1.1', 404, 'Not Found'}, _, _}}, symbol) do
    IO.inspect("downloading #{symbol} not found")
  end

  def save_xjllb({:error, :socket_closed_remotely}, symbol) do
    IO.inspect("downloading #{symbol} went wrong")
  end

  def save_lrb({:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}}, symbol) do
    File.write!("#{@root_dir}/csv/lrb/#{symbol}.csv", body)
  end

  def save_lrb({:ok, {{'HTTP/1.1', 404, 'Not Found'}, _, _}}, symbol) do
    IO.inspect("downloading #{symbol} not found")
  end

  def save_lrb({:error, _}, symbol) do
    IO.inspect("downloading #{symbol} went wrong")
  end
end
