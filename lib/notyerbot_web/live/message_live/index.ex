defmodule NotyerbotWeb.MessageLive.Index do
  use NotyerbotWeb, :live_view

  alias Notyerbot.Messages
  alias Notyerbot.Channels
  alias Notyerbot.Messages.Message

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:messages, list_messages())
     |> assign(:channel, nil)
     |> assign(:update_mode, "replace")
     |> assign(:guilds, list_guilds()), temporary_assigns: [messages: []]}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, %{"guild_id" => guild_id, "channel_id" => channel_id}) do
    Messages.subscribe(guild_id, channel_id)

    messages = Messages.list_by_guild_and_channel(guild_id, channel_id)
    channels = Channels.list_channels_for_guild(guild_id)
    channel = Channels.get_channel(guild_id, channel_id)

    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:messages, messages)
    |> assign(:channels, channels)
    |> assign(:channel, channel)
    |> assign(:message, nil)
  end

  defp apply_action(socket, :index, %{"guild_id" => guild_id}) do
    guild = Channels.get_guild(guild_id)
    channels = Channels.list_channels_for_guild(guild_id)

    socket
    |> assign(:page_title, guild.name)
    |> assign(:messages, [])
    |> assign(:channels, channels)
    |> assign(:message, nil)
  end

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:message, nil)
  end

  def handle_info({:new_message, message}, socket) do
    {:noreply,
     update(socket, :messages, fn messages ->
       Enum.take([message | messages], 100)
     end)}
  end

  defp list_messages do
    Messages.list_messages() |> Enum.take(100)
  end

  defp list_guilds do
    Channels.list_guilds()
  end
end
