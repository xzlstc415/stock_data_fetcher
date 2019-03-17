defmodule StockDataFetcherTest do
  use ExUnit.Case
  doctest StockDataFetcher

  test "greets the world" do
    assert StockDataFetcher.hello() == :world
  end
end
