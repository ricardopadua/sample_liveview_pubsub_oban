defmodule BearWeb.SampleOban do
  use Phoenix.LiveView

  alias Bear.Live.SampleOban.Components.Table
  alias Bear.Workers.SampleWorker

  def mount(_session, _params, socket) do
    if connected?(socket), do: Bear.subscribe_to_tax_generation_monitoring()

    taxes =
      Bear.get_tax()
      |> Enum.map(fn x ->
        %{
          name: x.name,
          type: x.type,
          amount: x.amount,
          attempt: x.attempt,
          last_attempt_timestamp: x.last_attempt_timestamp,
          status: x.status
        }
      end)

    socket =
      socket
      |> assign(registered_taxes: taxes)
      |> assign(tax_table_header: tax_table_header())

    {:ok, socket}
  end

  def handle_event("add_job", _params, socket) do

    :ok = Oban.Notifier.listen([:gossip])

      %{ids: [1,2,3]}
      |> SampleWorker.new()
      |> Oban.insert()

    {:noreply, socket}
  end

  def handle_info({:tax_generated, tax}, socket) do
    updated_taxes =
      socket.assigns.registered_taxes
      |> Enum.map(fn assigns_tax ->
        if assigns_tax.id == tax.id do
          tax
        else
          assigns_tax
        end
      end)

    {:noreply, assign(socket, :registered_taxes, updated_taxes)}
  end

  def tax_table_header() do
    [
      %{key: :name, value: "Name"},
      %{key: :type, value: "Type"},
      %{key: :amount, value: "Amount"},
      %{key: :attempt, value: "Processing Attempt"},
      %{key: :last_attempt_timestamp, value: "Last Attempt"},
      %{key: :status, value: "Status"}
    ]
  end
end
