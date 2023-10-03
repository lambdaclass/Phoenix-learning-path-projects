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

        IO.inspect(Messages.list_messages())

      socket =
        socket
        |> assign(messageForm: form, loading: false)
        |> stream(:messages, Messages.list_messages())

      # Logger.info(Messages.list_messages())

      {:ok, socket}
    else
      {:ok, assign(socket, loading: true)}
    end
  end

  @impl true
  def handle_event("send-message", %{"messageForm" => messageForm}, socket) do
    # Logger.info(messageForm)

    messageForm
    |> Map.put("userName", "test")
    |> Messages.save_message()
    |> case do
      {:ok, message} ->
        socket =
          socket
          |> put_flash(:info, "message sent")

          Phoenix.PubSub.broadcast(LiveviewChat.PubSub, "messages", { :new, message })

        {:noreply, socket}

      {:error, _changeset} ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_info({:new, message}, socket) do
    socket =
      socket
      |> put_flash(:info, "New message: #{message.message}")
      |> stream_insert(:messages, message, at: -1)

      {:noreply, socket}
  end
end
