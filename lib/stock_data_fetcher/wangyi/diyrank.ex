defmodule StockDataFetcher.WangyiApi do
  @wangyi_host "http://quotes.money.163.com/hs/service/diyrank.php"
  @fields "CODE,NAME,SYMBOL,PLATE_IDS"

  def fetch(count) do
    :httpc.request(["#{@wangyi_host}?count=#{count}&fields=#{@fields}"])
    |> handle_response
  end

  def handle_response({:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}}) do
    body
    |> Jason.decode
    |> elem(1)
    |> Map.get("list")
    |> Enum.each(&insert_stocks/1)
  end

  def handle_response({:ok, {{'HTTP/1.1', status_code, status}, _headers, _body}}) do
    IO.puts "#{status_code} #{status}"
  end

  def handle_response({:error, reson}) do
    IO.puts "error: #{reson}"
  end

  def insert_stocks(stock_raw_json) do
    stock_raw_json
    |> Map.to_list
    |> Enum.each(fn { k, v } -> IO.puts "#{k}: #{v}" end)
  end
end
