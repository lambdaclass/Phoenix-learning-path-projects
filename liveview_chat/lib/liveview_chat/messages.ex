defmodule LiveviewChat.Messages do
  import Ecto.Query, warn: false

  alias LiveviewChat.Repo
  alias LiveviewChat.Messages.Message

  def list_messages do
    query =
      from m in Message,
      select: m
      # order_by: [desc: inserted_at]

    Repo.all(query)
  end
end
