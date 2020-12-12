defmodule Notyerbot.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :author_id, :integer
    field :author_username, :string
    field :author_avatar, :string
    field :channel_id, :integer
    field :content, :string
    field :guild_id, :integer
    field :message_id, :integer
    field :timestamp, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [
      :guild_id,
      :channel_id,
      :message_id,
      :author_id,
      :author_username,
      :author_avatar,
      :content,
      :timestamp
    ])
    |> validate_required([
      :guild_id,
      :channel_id,
      :message_id,
      :author_id,
      :author_username,
      :author_avatar,
      :content,
      :timestamp
    ])
  end
end
