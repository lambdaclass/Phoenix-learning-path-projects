defmodule ToDoList.Repo do
  use Ecto.Repo,
    otp_app: :to_do_list,
    adapter: Ecto.Adapters.Postgres
end
