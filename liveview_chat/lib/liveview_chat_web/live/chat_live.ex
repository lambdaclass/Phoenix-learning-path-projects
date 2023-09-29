defmodule LiveviewChatWeb.ChatLive do
  use LiveviewChatWeb, :live_view
  alias LiveviewChat.Messages
  alias LiveviewChat.Messages.Message

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(LiveviewChat.PubSub, "messages")

      form =
        %Message{}
        |> Message.changeset(%{})
        |> to_form(as: "messageForm")

      socket =
        socket
        |> assign(messageForm: form, loading: false)
        |> stream(:messages, Messages.list_messages())

      {:ok, socket}
    else
      {:ok, assign(socket, loading: true)}
    end
  end

end
