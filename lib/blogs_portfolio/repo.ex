defmodule BlogsPortfolio.Repo do
  use Ecto.Repo,
    otp_app: :blogs_portfolio,
    adapter: Ecto.Adapters.Postgres
end
