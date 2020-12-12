defmodule Notyerbot.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :guild_id, :bigint
      add :channel_id, :bigint
      add :message_id, :bigint
      add :author_id, :bigint
      add :author_username, :string
      add :author_avatar, :string
      add :content, :text
      add :timestamp, :utc_datetime

      timestamps()
    end

  end
end
