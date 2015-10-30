defmodule TestRepo.Migrations.CreateWeathers do
  use Ecto.Migration

  def change do
    create table(:weather) do
      add :city,    :string
      add :date,    :date
      add :temp_lo, :integer
      add :temp_hi, :integer
      add :prcp,    :float, default: 0.0

      timestamps
    end
  end
end
