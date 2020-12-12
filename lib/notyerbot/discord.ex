defmodule Notyerbot.Discord do
  require Logger

  use Nostrum.Consumer

  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, msg, _ws_state}) do
    # guild_id, channel_id, message_id

    {:ok, _} =
      Notyerbot.Messages.create_message(%{
        guild_id: msg.guild_id,
        author_id: msg.author.id,
        author_username: msg.author.username,
        author_avatar: msg.author.avatar,
        channel_id: msg.channel_id,
        content: msg.content,
        message_id: msg.id,
        timestamp: msg.timestamp
      })

    case msg.content do
      "!m" ->
        Api.create_message(msg.channel_id, "You're doing good work!")

      "!raise" ->
        # This won't crash the entire Consumer.
        raise "No problems here!"

      _ ->
        :ignore
    end
  end

  @doc """
  Sent on server init
  """
  def handle_event({:GUILD_AVAILABLE, {%Nostrum.Struct.Guild{} = guild}, _state}) do
    {:ok, _guild} =
      Notyerbot.Channels.upsert_guild(guild.id, %{
        name: guild.name,
        icon: guild.icon,
        owner_id: guild.owner_id
      })

    Notyerbot.Channels.upsert_channels(guild.id, guild.channels)
  end

  def handle_event({event, payload, _state}) do
    IO.inspect(payload, label: event)
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_event) do
    :noop
  end
end
