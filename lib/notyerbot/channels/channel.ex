defmodule Notyerbot.Channels.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  schema "channels" do
    field :type, :integer
    field :guild_id, :integer
    field :channel_id, :integer
    field :name, :string
    field :parent_id, :integer
    field :position, :integer
    field :topic, :string

    timestamps()
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:type, :channel_id, :parent_id, :name, :topic, :position])
    |> validate_required([:type, :channel_id, :name])
  end
end
