defmodule AuthEx.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :title, :string
      add :url, :string

      timestamps()
    end

  end
end
