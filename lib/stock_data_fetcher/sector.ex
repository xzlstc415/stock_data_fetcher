defmodule StockDataFetcher.Sector do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sectors" do
    field :name, :string
    field :plate_id, :string
    field :type, :string
    many_to_many :stocks, StockDataFetcher.Stock, join_through: "sectors_stocks"
  end

  def changeset(sector, params \\ %{}) do
    sector
    |> cast(params, [:name, :plate_id])
    |> set_type_based_on_plate_id()
    |> validate_required([:plate_id, :type])
  end

  def set_type_based_on_plate_id(changeset) do
    plate_id = get_field(changeset, :plate_id)

    if (is_nil(plate_id)) do
      changeset
    else
      type = String.slice(plate_id, 0..1)
      put_change(changeset, :type, type)
    end
  end
end
