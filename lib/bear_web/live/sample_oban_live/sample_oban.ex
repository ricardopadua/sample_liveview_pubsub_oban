defmodule BearWeb.SampleOban do
  use Phoenix.LiveView

  alias Bear.Live.SampleOban.Components.Table
  alias Bear.Workers.GenerateTaxWorker

  def mount(_session, _params, socket) do
    if connected?(socket), do: Bear.subscribe_to_tax_generation_monitoring()

    taxes =
      Bear.get_tax()
      |> Enum.map(fn tax ->
        %{
          id: tax.id,
          name: tax.name,
          type: tax.type,
          amount: tax.amount,
          status: tax.status,
          attempt: tax.attempt,
          last_attempt_timestamp: tax.last_attempt_timestamp
        }
      end)

    socket =
      socket
      |> assign(registered_taxes: taxes)
      |> assign(tax_table_header: tax_table_header())

    {:ok, socket}
  end

  def handle_event("add_job", _, socket) do
    socket.assigns.registered_taxes
    |> Enum.reject(fn tax -> tax.status == "successfully_processed" end)
    |> Enum.map(fn tax ->  %{tax_id: tax.id} end)
    |> Enum.map(fn args -> GenerateTaxWorker.new(args) end)
    |> Oban.insert_all()

    {:noreply, socket}
  end

  def handle_info({:tax_generated, tax}, socket) do
    updated_taxes =
      socket.assigns.registered_taxes
      |> Enum.map(fn assigns_tax ->
        if assigns_tax.id == tax.id do
          %{
            id: tax.id,
            name: tax.name,
            type: tax.type,
            amount: tax.amount,
            status: tax.status,
            attempt: tax.attempt,
            last_attempt_timestamp: tax.last_attempt_timestamp
          }
        else
          assigns_tax
        end
      end)

      # IO.inspect(updated_taxes)


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
