defmodule Notyerbot.Channels.Guild do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guilds" do
    field :guild_id, :integer
    field :icon, :string
    field :name, :string
    field :owner_id, :integer

    timestamps()
  end

  @doc false
  def changeset(guild, attrs) do
    guild
    |> cast(attrs, [:guild_id, :name, :icon, :owner_id])
    |> validate_required([:guild_id, :name, :owner_id])
  end
end
