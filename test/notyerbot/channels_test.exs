defmodule Notyerbot.ChannelsTest do
  use Notyerbot.DataCase

  alias Notyerbot.Channels

  describe "guilds" do
    alias Notyerbot.Channels.Guild

    @valid_attrs %{icon: "some icon", id: 42, name: "some name", owner_id: 42}
    @update_attrs %{icon: "some updated icon", id: 43, name: "some updated name", owner_id: 43}
    @invalid_attrs %{icon: nil, id: nil, name: nil, owner_id: nil}

    def guild_fixture(attrs \\ %{}) do
      {:ok, guild} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Channels.create_guild()

      guild
    end

    test "list_guilds/0 returns all guilds" do
      guild = guild_fixture()
      assert Channels.list_guilds() == [guild]
    end

    test "get_guild!/1 returns the guild with given id" do
      guild = guild_fixture()
      assert Channels.get_guild!(guild.id) == guild
    end

    test "create_guild/1 with valid data creates a guild" do
      assert {:ok, %Guild{} = guild} = Channels.create_guild(@valid_attrs)
      assert guild.icon == "some icon"
      assert guild.id == 42
      assert guild.name == "some name"
      assert guild.owner_id == 42
    end

    test "create_guild/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Channels.create_guild(@invalid_attrs)
    end

    test "update_guild/2 with valid data updates the guild" do
      guild = guild_fixture()
      assert {:ok, %Guild{} = guild} = Channels.update_guild(guild, @update_attrs)
      assert guild.icon == "some updated icon"
      assert guild.id == 43
      assert guild.name == "some updated name"
      assert guild.owner_id == 43
    end

    test "update_guild/2 with invalid data returns error changeset" do
      guild = guild_fixture()
      assert {:error, %Ecto.Changeset{}} = Channels.update_guild(guild, @invalid_attrs)
      assert guild == Channels.get_guild!(guild.id)
    end

    test "delete_guild/1 deletes the guild" do
      guild = guild_fixture()
      assert {:ok, %Guild{}} = Channels.delete_guild(guild)
      assert_raise Ecto.NoResultsError, fn -> Channels.get_guild!(guild.id) end
    end

    test "change_guild/1 returns a guild changeset" do
      guild = guild_fixture()
      assert %Ecto.Changeset{} = Channels.change_guild(guild)
    end
  end

  describe "channels" do
    alias Notyerbot.Channels.Channel

    @valid_attrs %{id: 42, name: "some name", parent_id: 42, position: 42, topic: "some topic"}
    @update_attrs %{id: 43, name: "some updated name", parent_id: 43, position: 43, topic: "some updated topic"}
    @invalid_attrs %{id: nil, name: nil, parent_id: nil, position: nil, topic: nil}

    def channel_fixture(attrs \\ %{}) do
      {:ok, channel} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Channels.create_channel()

      channel
    end

    test "list_channels/0 returns all channels" do
      channel = channel_fixture()
      assert Channels.list_channels() == [channel]
    end

    test "get_channel!/1 returns the channel with given id" do
      channel = channel_fixture()
      assert Channels.get_channel!(channel.id) == channel
    end

    test "create_channel/1 with valid data creates a channel" do
      assert {:ok, %Channel{} = channel} = Channels.create_channel(@valid_attrs)
      assert channel.id == 42
      assert channel.name == "some name"
      assert channel.parent_id == 42
      assert channel.position == 42
      assert channel.topic == "some topic"
    end

    test "create_channel/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Channels.create_channel(@invalid_attrs)
    end

    test "update_channel/2 with valid data updates the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{} = channel} = Channels.update_channel(channel, @update_attrs)
      assert channel.id == 43
      assert channel.name == "some updated name"
      assert channel.parent_id == 43
      assert channel.position == 43
      assert channel.topic == "some updated topic"
    end

    test "update_channel/2 with invalid data returns error changeset" do
      channel = channel_fixture()
      assert {:error, %Ecto.Changeset{}} = Channels.update_channel(channel, @invalid_attrs)
      assert channel == Channels.get_channel!(channel.id)
    end

    test "delete_channel/1 deletes the channel" do
      channel = channel_fixture()
      assert {:ok, %Channel{}} = Channels.delete_channel(channel)
      assert_raise Ecto.NoResultsError, fn -> Channels.get_channel!(channel.id) end
    end

    test "change_channel/1 returns a channel changeset" do
      channel = channel_fixture()
      assert %Ecto.Changeset{} = Channels.change_channel(channel)
    end
  end
end
