defmodule TestRepo.Migrations.CreateChangesets do
  use Ecto.Migration

  def change do
    create table(:changesets) do
      add :table_name, :string,  null: false
      add :record_id,  :integer, null: false
      add :operation,  :string,  null: false
      add :changes,    :jsonb

      timestamps
    end
  end
end
