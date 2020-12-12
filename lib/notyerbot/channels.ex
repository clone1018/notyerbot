defmodule Notyerbot.Channels do
  @moduledoc """
  The Channels context.
  """

  import Ecto.Query, warn: false
  alias Notyerbot.Repo

  alias Notyerbot.Channels.Guild
  alias Notyerbot.Channels.Channel

  @doc """
  Returns the list of guilds.

  ## Examples

      iex> list_guilds()
      [%Guild{}, ...]

  """
  def list_guilds do
    Repo.all(Guild)
  end

  def list_channels_for_guild(guild_id) do
    Repo.all(
      from c in Channel,
        where: c.guild_id == ^guild_id
    )
    |> Enum.sort_by(& &1.parent_id)
  end

  def get_guild(guild_id), do: Repo.get_by(Guild, guild_id: guild_id)

  def upsert_guild(guild_id, attrs \\ %{}) do
    case get_guild(guild_id) do
      nil -> %Guild{guild_id: guild_id}
      guild -> guild
    end
    |> Guild.changeset(attrs)
    |> Repo.insert_or_update()
  end

  def get_channel(guild_id, channel_id) do
    Repo.get_by(Channel, guild_id: guild_id, channel_id: channel_id)
  end

  def upsert_channels(guild_id, channels) do
    Enum.each(channels, fn {channel_id, channel} ->
      upsert_channel(guild_id, channel_id, %{
        type: channel.type,
        name: channel.name,
        parent_id: channel.parent_id,
        position: channel.position,
        topic: channel.topic
      })
    end)
  end

  def upsert_channel(guild_id, channel_id, attrs \\ %{}) do
    case get_channel(guild_id, channel_id) do
      nil ->
        %Channel{
          guild_id: guild_id,
          channel_id: channel_id
        }

      channel ->
        channel
    end
    |> Channel.changeset(attrs)
    |> Repo.insert_or_update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guild changes.

  ## Examples

      iex> change_guild(guild)
      %Ecto.Changeset{data: %Guild{}}

  """
  def change_guild(%Guild{} = guild, attrs \\ %{}) do
    Guild.changeset(guild, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking channel changes.

  ## Examples

      iex> change_channel(channel)
      %Ecto.Changeset{data: %Channel{}}

  """
  def change_channel(%Channel{} = channel, attrs \\ %{}) do
    Channel.changeset(channel, attrs)
  end
end
