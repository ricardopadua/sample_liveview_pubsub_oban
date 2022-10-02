defmodule Bear.Workers.SampleWorker do
  use Oban.Worker,
  queue: :sample,
  priority: 1,
  max_attempts: 10,
  tags: ["perform"],
  unique: [period: 3]

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"ids" => ids}}) do
    Enum.map(ids, fn id -> IO.inspect(id) end)
    Oban.Notifier.notify(:gossip, %{complete: ids})
  end
end
