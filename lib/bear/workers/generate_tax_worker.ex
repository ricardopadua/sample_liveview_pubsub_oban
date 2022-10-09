defmodule Bear.Workers.GenerateTaxWorker do
  alias Bear.Tax

  use Oban.Worker,
  queue: :tax,
  priority: 1,
  max_attempts: 10,
  tags: ["perform"],
  unique: [period: 3]

  @impl Oban.Worker
  def perform(%Oban.Job{attempt: attempt, args: %{"tax_id" => tax_id}}) do
    generate_random_tax()
    |> case do
      {:ok, :successfully_processed} ->
        handle_result_generate_tax(tax_id, :successfully_processed, attempt)

        {:ok, :successfully_processed}

      {:error, :processing} ->
        handle_result_generate_tax(tax_id, :processing, attempt)

        {:error, :processing}

      {:error, :processed_with_error} ->
        handle_result_generate_tax(tax_id, :processed_with_error, attempt)

        {:error, :processed_with_error}
    end
  end

  defp handle_result_generate_tax(tax_id, status, attempt) do
    Bear.get_tax!(tax_id)
    |> Ecto.Changeset.change(%{
      status: Atom.to_string(status),
      attempt: attempt,
      last_attempt_timestamp: DateTime.utc_now() |> DateTime.truncate(:second)
    })
    |> Bear.Repo.update!
    |> Bear.broadcast_tax_generation_monitoring
  end

  defp initialize_process(tax_id, status, attempt) do
    Bear.get_tax!(tax_id)
    |> Ecto.Changeset.change(%{
      status: Atom.to_string(status),
      attempt: attempt,
    })
    |> Bear.broadcast_tax_generation_monitoring

    :timer.sleep(4000);
  end

  defp generate_random_tax() do
    1..6
    |> Enum.random()
    |> case do
      1 -> {:ok, :successfully_processed}
      2 -> {:error, :processing}
      _ -> {:error, :processed_with_error}
    end
  end
end
