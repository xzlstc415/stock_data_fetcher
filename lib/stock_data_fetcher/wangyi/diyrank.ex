defmodule StockDataFetcher.WangyiApi do
  alias StockDataFetcher.{Repo, Stock, Sector}

  @wangyi_host "http://quotes.money.163.com/hs/service/diyrank.php"
  @fields "CODE,NAME,SYMBOL,PLATE_IDS"

  def fetch_all do
    0..19
    |> Enum.each(fn n -> fetch(1000, n) end)
  end

  def fetch(count, page) do
    :httpc.request(["#{@wangyi_host}?count=#{count}&fields=#{@fields}&page=#{page}"])
    |> handle_response
  end

  def handle_response({:ok, {{'HTTP/1.1', 200, 'OK'}, _headers, body}}) do
    body
    |> Jason.decode()
    |> elem(1)
    |> Map.get("list")
    |> Enum.each(&insert_stocks/1)
  end

  def handle_response({:ok, {{'HTTP/1.1', status_code, status}, _headers, _body}}) do
    IO.puts("#{status_code} #{status}")
  end

  def handle_response({:error, reson}) do
    IO.puts("error: #{reson}")
  end

  def insert_stocks(raw_json) do
    stock = insert_stock(raw_json)
    sectors = insert_sectors(raw_json)

    case sectors do
      [] -> nil
      list -> insert_sector_stocks(stock, sectors)
    end
  end

  def stock_field_mapping(key) do
    %{
      "CODE" => :code,
      "NAME" => :name,
      "SYMBOL" => :symbol
    }[key]
  end

  def sector_field_mapping(key) do
    %{
      "PLATE_IDS" => :plate_ids
    }[key]
  end

  def insert_stock(raw_json) do
    raw_json
    |> Enum.map(fn {k, v} -> {stock_field_mapping(k), v} end)
    |> Enum.filter(fn {k, _} -> k end)
    |> Enum.into(%{})
    |> find_or_create_stock
  end

  def insert_sectors(raw_json) do
    raw_json
    |> Enum.map(fn {k, v} -> {sector_field_mapping(k), v} end)
    |> Enum.filter(fn {k, _} -> k end)
    |> Enum.into(%{})
    |> Map.get(:plate_ids)
    |> Enum.map(fn plate_id -> find_or_create_sector(plate_id) end)
  end

  def find_or_create_stock(stock) do
    result =
      case Repo.get_by(Stock, code: stock.code) do
        nil -> %Stock{}
        exist_record -> exist_record
      end
      |> Stock.changeset(stock)
      |> Repo.insert_or_update()

    case result do
      {:ok, model} -> model
      {:error, changeset} -> IO.puts(changeset.errors)
    end
  end

  def find_or_create_sector(plate_id) do
    result =
      case Repo.get_by(Sector, plate_id: plate_id) do
        nil -> %Sector{}
        exist_record -> exist_record
      end
      |> Sector.changeset(%{plate_id: plate_id})
      |> Repo.insert_or_update()

    case result do
      {:ok, model} -> model
      {:error, changeset} -> IO.puts(changeset.errors)
    end
  end

  def insert_sector_stocks(stock, sectors) do
    stock
    |> Repo.preload(:sectors)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(:sectors, sectors)
    |> Repo.update()
  end
end
