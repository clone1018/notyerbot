defmodule Notyerbot.Repo.Migrations.CreateGuilds do
  use Ecto.Migration

  def change do
    create table(:guilds) do
      add :guild_id, :bigint
      add :name, :string
      add :icon, :string
      add :owner_id, :bigint

      timestamps()
    end

  end
end
