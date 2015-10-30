defmodule Continuum.Changeset do
  use Ecto.Model
  use Ecto.Model.Timestamps

  schema "changesets" do
    field :table_name
    field :record_id, :integer
    field :operation
    field :changes,   :map

    timestamps
  end
end
