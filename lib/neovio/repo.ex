defmodule Neovio.Repo do
  use Ecto.Repo,
    otp_app: :neovio,
    adapter: Ecto.Adapters.SQLite3
end
