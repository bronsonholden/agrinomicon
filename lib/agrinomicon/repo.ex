defmodule Agrinomicon.Repo do
  use Ecto.Repo,
    otp_app: :agrinomicon,
    adapter: Ecto.Adapters.Postgres
end
