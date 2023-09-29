defmodule LiveviewChat.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message, :string
      add :userName, :string

      timestamps()
    end
  end
end
