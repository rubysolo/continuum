defmodule Continuum.Weather do
  use Ecto.Model
  use Ecto.Model.Timestamps
  use Continuum

  schema "weather" do
    field :city
    field :date,    Ecto.Date
    field :temp_lo, :integer
    field :temp_hi, :integer
    field :prcp,    :float, default: 0.0

    timestamps
  end

  @required_params ~w(city date)
  @optional_params ~w(temp_lo temp_hi prcp)

  def changeset(model, params) do
    model
    |> cast(params, @required_params, @optional_params)
  end
end
