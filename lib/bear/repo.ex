defmodule Bear.Repo do
  use Ecto.Repo,
    otp_app: :bear,
    adapter: Ecto.Adapters.Postgres
end
