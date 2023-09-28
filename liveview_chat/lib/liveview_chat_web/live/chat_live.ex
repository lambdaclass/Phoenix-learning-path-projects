defmodule LiveviewChatWeb.ChatLive do
  use LiveviewChatWeb, :live_view
  alias LiveviewChat.Message

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
      <h1 class="text-2xl">ChatView</h1>
    """
  end
end
