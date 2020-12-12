defmodule Notyerbot.MessagesTest do
  use Notyerbot.DataCase

  alias Notyerbot.Messages

  describe "messages" do
    alias Notyerbot.Messages.Message

    @valid_attrs %{author_id: 42, author_username: "some author_username", channel_id: 42, content: "some content", guild_id: 42, message_id: 42, timestamp: "2010-04-17T14:00:00Z"}
    @update_attrs %{author_id: 43, author_username: "some updated author_username", channel_id: 43, content: "some updated content", guild_id: 43, message_id: 43, timestamp: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{author_id: nil, author_username: nil, channel_id: nil, content: nil, guild_id: nil, message_id: nil, timestamp: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Messages.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Messages.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Messages.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Messages.create_message(@valid_attrs)
      assert message.author_id == 42
      assert message.author_username == "some author_username"
      assert message.channel_id == 42
      assert message.content == "some content"
      assert message.guild_id == 42
      assert message.message_id == 42
      assert message.timestamp == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Messages.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Messages.update_message(message, @update_attrs)
      assert message.author_id == 43
      assert message.author_username == "some updated author_username"
      assert message.channel_id == 43
      assert message.content == "some updated content"
      assert message.guild_id == 43
      assert message.message_id == 43
      assert message.timestamp == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Messages.update_message(message, @invalid_attrs)
      assert message == Messages.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Messages.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Messages.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Messages.change_message(message)
    end
  end
end
