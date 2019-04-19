defmodule StockDataFetcher.Parser do
  @float_regex ~r/^-?(?<int>\d+)(\.(?<dec>\d+))?$/

  def parse_number(str) do
    %{"dec" => decimal_str} = Regex.named_captures(@float_regex, str)

    case decimal_str do
      "" ->
        String.to_integer(str)

      _ ->
        String.to_float(str)
    end
  end
end
