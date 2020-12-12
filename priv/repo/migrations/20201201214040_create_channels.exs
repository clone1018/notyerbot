defmodule Notyerbot.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :type, :integer
      add :guild_id, :bigint
      add :channel_id, :bigint
      add :parent_id, :bigint
      add :name, :string
      add :topic, :string
      add :position, :integer

      timestamps()
    end

  end
end
