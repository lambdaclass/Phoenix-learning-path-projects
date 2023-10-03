defmodule Append.Address do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime_usec]
  schema "addresses" do
    field :name, :string
    field :address_line_1, :string
    field :address_line_2, :string
    field :city, :string
    field :postcode, :string
    field :tel, :string

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name, :address_line_1, :address_line_2, :city, :postcode, :tel])
    |> validate_required([:name, :address_line_1, :address_line_2, :city, :postcode, :tel])
  end
end
