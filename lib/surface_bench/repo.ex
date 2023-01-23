defmodule SurfaceBench.Repo do
  use Ecto.Repo,
    otp_app: :surface_bench,
    adapter: Ecto.Adapters.Postgres
end
