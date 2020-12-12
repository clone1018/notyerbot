defmodule Notyerbot.Repo do
  use Ecto.Repo,
    otp_app: :notyerbot,
    adapter: Ecto.Adapters.Postgres
end
