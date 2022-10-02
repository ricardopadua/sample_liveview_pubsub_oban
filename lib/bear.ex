defmodule Bear do
  @moduledoc """
  Bear keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias Bear.Repo
  alias Bear.Tax
  alias Bear.Workers.GenerateTaxWorker

  @tax_topic "tax"

  def get_tax(), do: Tax |> Repo.all()
  def get_tax!(id), do: Repo.get!(Tax, id)


  @spec update_tax(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  def update_tax(attr) do
    Tax.changeset(%Tax{}, attr)
    |> Repo.update!()
  end


  @spec generate_tax(nonempty_maybe_improper_list) :: :ok
  def generate_tax(taxes = [%Tax{} | _]) do
    taxes
    |> Enum.each(fn tax ->
      %{tax_id: tax.id}
      |> GenerateTaxWorker.new()
      |> Oban.insert()
    end)
  end

  @spec subscribe_to_tax_generation_monitoring :: :ok | {:error, {:already_registered, pid}}
  def subscribe_to_tax_generation_monitoring() do
    Phoenix.PubSub.subscribe(Bear.PubSub, @tax_topic)
  end

  @spec broadcast_tax_generation_monitoring(any) :: :ok | {:error, any}
  def broadcast_tax_generation_monitoring(tax = %Tax{}) do
    Phoenix.PubSub.broadcast(
      Bear.PubSub,
      @tax_topic,
      {:tax_generated, tax}
    )
  end
end
