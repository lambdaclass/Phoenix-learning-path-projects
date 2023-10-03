defmodule LiveviewChat.Messages do
  import Ecto.Query, warn: false

  alias LiveviewChat.Repo
  alias LiveviewChat.Messages.Message

  def list_messages do
    query =
      from m in Message,
      select: %{id: m.id, message: m.message, userName: m.userName, inserted_at: m.inserted_at},
      order_by: [asc: m.inserted_at]

    Repo.all(query)
  end

  def save_message(message_params) do
    %Message{}
    |> Message.changeset(message_params)
    |> Repo.insert()
  end
end
