defmodule Bear.Repo.Migrations.CreateTax do
  use Ecto.Migration

  def up do
    create table(:taxes) do
      add :name, :string, null: false
      add :type, :string, null: false
      add :amount, :decimal, null: false
      add :status, :string, default: "waiting_to_processing", null: false
      add :attempt, :integer, default: 0, null: false
      add :last_attempt_timestamp, :utc_datetime

      timestamps()
    end
  end

  def down do
    drop_if_exists table(:taxes)
  end
end
