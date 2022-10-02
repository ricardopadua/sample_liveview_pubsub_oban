defmodule Bear.Tax do
  use Ecto.Schema
  import Ecto.Changeset

  @allowed_types ~w(IOF IR)a

  @allowed_status ~w(waiting_to_processing processing processed_with_error successfully_processed)a

  @fields ~w(name type precessing_status attempt last_attempt_timestamp)a

  schema "taxes" do
    field :name, :string
    field :type, :string
    field :amount, :decimal
    field :status, :string, default: "waiting_to_processing"
    field :attempt, :integer, default: 0
    field :last_attempt_timestamp, :utc_datetime

    timestamps()
  end

  def changeset(schema = %__MODULE__{}, attrs) do
    schema
    |> cast(attrs, @fields)
    |> validate_inclusion(:type, @allowed_types)
    |> validate_inclusion(:type, @allowed_status)
  end
end
